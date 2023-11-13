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
sudo serve 80 build --spa
sleep 1
echo $! > .pidfile
set +x

echo 'Build complete.'