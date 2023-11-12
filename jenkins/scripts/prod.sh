set -x
npm run build
sudo pm2 serve 80 build --spa
set +x