#!/usr/bin/env bash

#### Command 'aliases'
CURL="command curl"
GPG=gpg2
BUNDLE="bin/bundle"
# someday CentOS will catch up
DNF=yum

#### required RPMs
PSQL_RPMS="postgresql postgresql-libs postgresql-contrib postgresql-devel postgresql-server"

#### useful functions
exit_with_error () {
    echo "$1" >&2
    exit "$2"
}

export -f exit_with_error

postgres () {
  runuser postgres -c "$@"
  return $?
}


#### get RPMS
# shellcheck disable=SC2086
${DNF} install -y ${PSQL_RPMS} || exit_with_error "${DNF} install of PostgresSQL failed!" 4

#### set up Postgres
postgres "postgresql-setup initdb"

systemctl enable postgresql

systemctl start postgresql

echo "************ Completed $(basename $0) ******************"
