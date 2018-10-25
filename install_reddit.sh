#!/bin/sh
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
sudo apt update
sudo apt -y upgrade
sudo apt install -y build-essential ruby-full ruby-bundler mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
git clone -b monolith https://github.com/express42/reddit.git
cd reddit 
bundle install
puma -d
