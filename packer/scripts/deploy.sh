#!/bin/sh
set -e

case $# in
0) user="appuser" ;;
*) user=$1 ;;
esac

cd /home/$user
git clone -b monolith https://github.com/express42/reddit.git
cd reddit  &&  bundle install

sudo systemctl daemon-reload
sudo systemctl enable reddit.service
