#!/usr/bin/env bash

#### Constants
RVERSION=2.6.3
NODE_VERSION='lts/*'
ADMIN_USER=deploy
SOURCE=https://github.com/alflanagan/DevcampPortfolio.git
DEST=/home/${ADMIN_USER}/build/DevcampPortfolio

export NODE_VERSION

#### Command 'aliases'
CURL="command curl"
GPG=gpg2
BUNDLE="bin/bundle"
# someday CentOS will catch up
DNF=yum

#### required RPMs
RUBY_BUILD_DEPS="patch autoconf automake bison gcc-c++ libffi-devel libtool patch readline-devel"
RUBY_BUILD_DEPS="${RUBY_BUILD_DEPS} ruby sqlite-devel zlib-devel glibc-headers glibc-devel openssl-devel"
OTHER_DEPS="curl git docker"

#### useful functions
exit_with_error () {
    echo "$1" >&2
    exit "$2"
}

export -f exit_with_error

create_rvm_user () {
    echo "Creating user $1"
    groupadd -f rvm
    grep -q "$1" /etc/passwd || useradd -m -G rvm,wheel -U "$1" || exit_with_error "Failed to create user $1!!" 1
}

deploy () {
    runuser ${ADMIN_USER} -c "$1"
    return $?
}

install_node () {
  echo "installing node ${NODE_VERSION} for ${USER}"
  NVM_DIR=${HOME}/.nvm
  if [[ ! -d ${NVM_DIR} ]]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
  fi
  # ensure nvm is present
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm ls ${NODE_VERSION} || {
    nvm install ${NODE_VERSION}
    nvm alias default ${NODE_VERSION}
  }
  nvm use ${NODE_VERSION}
}

export -f install_node

setup_postgres () {
  #### required RPMs
  PSQL_RPMS="postgresql postgresql-libs postgresql-contrib postgresql-devel postgresql-server"
  #### get RPMS
  # shellcheck disable=SC2086
  ${DNF} install -y ${PSQL_RPMS} || exit_with_error "${DNF} install of PostgresSQL failed!" 4

  #### init data directories
  runuser postgres -c "postgresql-setup initdb"

  systemctl enable postgresql

  systemctl start postgresql

  echo "************ Completed $(basename $0) ******************"
}

#### get RPMS
# shellcheck disable=SC2086
${DNF} install -y ${RUBY_BUILD_DEPS} || exit_with_error "${DNF} install of package failed!" 4

${DNF} install -y ${OTHER_DEPS} || exit_with_error "Can't install a dependency!" 5

setup_postgres

#### user-side setup
create_rvm_user ${ADMIN_USER}

ruby_script=$(cat <<RUBY
  cd
  if [[ ! -d ~/.rvm ]]; then
    ${CURL} -sSL https://rvm.io/mpapis.asc | ${GPG} --import -
    ${CURL} -sSL https://rvm.io/pkuczynski.asc | ${GPG} --import -
    ${CURL} -sSL https://get.rvm.io | bash -s --help --rails || exit_with_error 'Unable to install rvm or ruby' 3
    rvm install ${RVERSION}
  fi
RUBY
)

deploy "${ruby_script}"

deploy install_node

echo "ruby_script completed"

git_script=$(cat <<-GIT
  . ~/.rvm/scripts/rvm
  rvm use ${RVERSION}
  if [[ ! -d "${DEST}" ]]; then
    echo "${DEST} not found"
    ls -A build
    mkdir -p ~/build
    cd ~/build
    git clone ${SOURCE} || exit_with_error "Failure cloning repository from ${SOURCE}" 7
  fi
  cd "${DEST}" || exit_with_error "Directory ${DEST} not created!"
  git checkout view
  gem install bundler -v '< 2'
  ${BUNDLE} install --deployment --without=development
GIT
)

deploy "${git_script}"

echo "git_script completed" >&2
