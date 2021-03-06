#!/usr/bin/env bash

#### Constants
RVERSION=2.6.3
NODE_VERSION='lts/*'
ADMIN_USER=deploy
PSQL_CONF=/var/lib/pgsql/data/pg_hba.conf

export ADMIN_USER NODE_VERSION RVERSION PSQL_CONF

#### Commands
# don't show progress, do show errors
CURL="command curl -s -S"
GPG=gpg2
BUNDLE="bin/bundle"
# someday CentOS will catch up
DNF=yum
export CURL GPG BUNDLE DNF

#### required RPMs
RUBY_BUILD_DEPS="patch autoconf automake bison gcc-c++ libffi-devel libtool patch readline-devel"
RUBY_BUILD_DEPS="${RUBY_BUILD_DEPS} ruby sqlite-devel zlib-devel glibc-headers glibc-devel openssl-devel"
POSTGRES_DEPS="postgresql postgresql-libs postgresql-contrib postgresql-devel postgresql-server"
OTHER_DEPS="curl git"
export RUBY_BUILD_DEPS POSTGRES_DEPS OTHER_DEPS

#### useful functions
exit_with_error () {
    echo "$1" >&2
    exit "$2"
}

export -f exit_with_error

create_rvm_user () {
  echo "provision: ${FUNCNAME[0]} entered as ${USER}"
  grep rvm /etc/group > /dev/null && {
    echo "provision: ${FUNCNAME[0]} exiting, already done"
    return
  }

  echo "Creating user $1"
  groupadd -f rvm
  grep -q "$1" /etc/passwd || useradd -m -G rvm,wheel -U "$1" || exit_with_error "Failed to create user $1!!" 1
  local ERR=$?
  echo "provision: ${FUNCNAME[0]} completed."
  return $ERR
}

install_node () {
  echo "provision: ${FUNCNAME[0]} entered as ${USER}"
  local NVM_DIR=${HOME}/.nvm
  cd
  if [[ -d ${NVM_DIR} ]]; then
    echo "provision: ${FUNCNAME[0]}: exiting, already done!"
    return
  else
    echo "provision: ${FUNCNAME[0]}: Downloading nvm"
    ${CURL} -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
  fi
  # ensure nvm is present
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm ls ${NODE_VERSION} || {
    nvm install ${NODE_VERSION}
    nvm alias default ${NODE_VERSION}
  }
  nvm use ${NODE_VERSION}
  local ERR=$?
  echo "provision: ${FUNCNAME[0]} completed."
  return $ERR
}

install_ruby () {
  echo "provision: ${FUNCNAME[0]} entered as ${USER}"
  if [[ -f ~/.rvm/scripts/rvm ]]; then
    echo "provision: ${FUNCNAME[0]} exited, done already"
    return
  fi

  cd
  if [[ ! -d ~/.rvm ]]; then
    ${CURL} -sSL https://rvm.io/mpapis.asc | ${GPG} --import -
    ${CURL} -sSL https://rvm.io/pkuczynski.asc | ${GPG} --import -
    ${CURL} -sSL https://get.rvm.io | bash -s stable --rails || exit_with_error 'Unable to install rvm or ruby' 3
    . ~/.rvm/scripts/rvm
    rvm install ${RVERSION} || exit_with_error "Unable to install ruby version ${RVERSION}"
  fi
  local ERR=$?
  echo "provision: ${FUNCNAME[0]} completed."
  return $ERR
}

clone_repo () {
  echo "provision: ${FUNCNAME[0]} entered as ${USER}"
  local SOURCE=https://github.com/alflanagan/DevcampPortfolio.git
  local DEST=/home/${ADMIN_USER}/build/DevcampPortfolio
  local BRANCH=view

  if [[ -d ~/build/DevcampPortfolio/vendor/bundle ]]; then
    echo "provision: ${FUNCNAME[0]} exiting, already done."
    return
  fi
  cd
  . ~/.rvm/scripts/rvm
  rvm use ${RVERSION}
  if [[ ! -d "${DEST}" ]]; then
    mkdir -p ~/build
    cd ~/build
    git clone ${SOURCE} || exit_with_error "Failure cloning repository from ${SOURCE}" 7
  fi
  cd "${DEST}" || exit_with_error "Directory ${DEST} not created!"
  git checkout ${BRANCH}
  echo "${FUNCNAME[0]} using ruby version $(ruby -v)"
  gem install bundler -v '< 2'
  ${BUNDLE} install --deployment --path=vendor/bundle
  local ERR=$?
  echo "provision: ${FUNCNAME[0]} completed."
  return $ERR
}

setup_rails_server () {
  local DEST=/home/${ADMIN_USER}/build/DevcampPortfolio
  local NVM_DIR=${HOME}/.nvm
  cd
  . .bash_profile
  . .bashrc

  rvm use ${RVERSION}
  nvm use ${NODE_VERSION}

  cd ${DEST}
  bin/rails db:create
  bin/rails db:migrate
}

export -f install_node install_ruby clone_repo setup_rails_server

do_as_deploy () {
  echo "provision: ${FUNCNAME[0]} entered as ${USER}"
  runuser ${ADMIN_USER} -c install_ruby
  runuser ${ADMIN_USER} -c install_node
  runuser ${ADMIN_USER} -c clone_repo
  local ERR=$?
  if [[ $ERR -eq 0 ]]; then
    runuser ${ADMIN_USER} -c setup_rails_server
    ERR=$?
  fi
  echo "provision: ${FUNCNAME[0]} completed."
  return $ERR
}

setup_postgres () {
  echo "provision: ${FUNCNAME[0]} entered as ${USER}"

  #### get RPMS
  # shellcheck disable=SC2086
  ${DNF} install -y ${POSTGRES_DEPS} || exit_with_error "${DNF} install of PostgresSQL failed!" 4

  #### init data directories
  runuser postgres -c "postgresql-setup initdb"

  echo "local   devcampportfolio_development  deploy                            md5" >> ${PSQL_CONF}
  echo "local   devcampportfolio_test     deploy                              md5" >> ${PSQL_CONF}

  #### start it
  systemctl enable postgresql
  systemctl start postgresql

  ### Set up database user. Hardcoded password for temporary use only!
  echo "CREATE USER deploy CREATEDB PASSWORD 'dumbpassword';" > /tmp/temp_user.sql
  runuser postgres -c 'psql -f /tmp/temp_user.sql'

  local ERR=$?
  echo "provision: ${FUNCNAME[0]} completed."
  return $ERR
}

#### get RPMS
# shellcheck disable=SC2086
rpm -q gcc-c++ > /dev/null || ${DNF} install -y ${RUBY_BUILD_DEPS} || exit_with_error "${DNF} install of package failed!" 4

rpm -q git > /dev/null || ${DNF} install -y ${OTHER_DEPS} || exit_with_error "Can't install a dependency!" 5

rpm -q postgresql-server > /dev/null || setup_postgres

#### user-side setup
create_rvm_user ${ADMIN_USER}

do_as_deploy
