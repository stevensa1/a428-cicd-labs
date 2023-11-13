#!/usr/bin/env sh
echo 'Restoring repository state..'
set -x
git add .
git stash
git pull
set +x

echo 'Installing dependencies...'
set -x
npm install --prefer-offline --no-audit --progress=false
set +x

echo 'Building your Node.js/React application for production...'
set -x
npm run build
nohup sudo serve -s build -l 80 > serve.log 2>&1 &
SERVER_PID=$!
echo $SERVER_PID > .pidfile
set +x

echo 'Build complete.'