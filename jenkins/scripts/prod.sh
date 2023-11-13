#!/usr/bin/env sh

set -x
npm run build
serve 80 build --spa
sleep 1
echo $! > .pidfile
set +x