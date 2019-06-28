#!/usr/bin/env sh
# special case of codefind.sh, search all files for a string

if [ $# -eq 0 ]; then
  echo "You must supply a search string or pattern."
else
  ./codefind.sh -exec grep "$@" '{}' +
fi
