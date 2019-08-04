#!/usr/bin/env dash
exec ./codefind.sh -name '*.coffee' -exec coffeelint '{}' \;
