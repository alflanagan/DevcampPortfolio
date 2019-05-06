#!/usr/bin/env sh
# helper script to run find on files while excluding a whole bunch of stuff we
# don't care about

PRUNED=(.git doc log node_modules tmp vendor)

PRUNE_CLAUSE=""
for X in ${PRUNED[@]}
do
  PRUNE_CLAUSE="${PRUNE_CLAUSE} -name ${X} -prune -o"
done

if [ $# -eq 0 ]; then
  find . ${PRUNE_CLAUSE} -type f -print
else
  # good way to detect when no action specified so we can add -print automatically?
  find . ${PRUNE_CLAUSE} -type f "$@"
fi
