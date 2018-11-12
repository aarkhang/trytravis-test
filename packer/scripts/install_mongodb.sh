#!/bin/sh
#
# Install MongoDB Community Edition on Ubuntu
#
# Exit shell if any subcommand or pipeline returns a non-zero status.
set -e

DISTR=`lsb_release -i -s`
CODENAME=`lsb_release -c -s`
RELEASE=`lsb_release -r -s`

if [ "$DISTR" != "Ubuntu" ]; then
 echo Unsupported OS
 exit 1
fi    

case $# in
0) ver="3.6" ;;
*) ver=$1 ;;
esac

ORG_PKG="mongodb-org-server"
CONF="/etc/mongod.conf"
PACKAGE=$ORG_PKG

if [ "$CODENAME" = "bionic" ]; then
 case $ver in
	3.6) PACKAGE="mongodb-server" ; CONF="/etc/mongodb.conf" ;;
	4.0) key="9DA31620334BD75D9DCB49F368818C72E52529D4" ;;
	*) echo Unsupported MongoDB version for Ubuntu 18.04;  exit 2 ;;
 esac
else
 case $ver in
	3.2) key="EA312927" ;;
	3.4) key="0C49F3730359A14518585931BC711F9BA15703C6" ;;
	3.6) key="2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5" ;;
	4.0) key="9DA31620334BD75D9DCB49F368818C72E52529D4" ;;
	*) echo Invalid MongoDB version \(use 3.2,3.4,3.6 or 4.0\); echo usage: $0 [version] ; exit 2 ;;
 esac
fi    
if [ "$PACKAGE" = "$ORG_PKG" ]; then
 apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv $key
 echo "deb http://repo.mongodb.org/apt/ubuntu $CODENAME/mongodb-org/$ver multiverse" > /etc/apt/sources.list.d/mongodb-org-$ver.list
fi
echo "Installing $PACKAGE $ver on $DISTR $RELEASE"
apt-get update
apt-get install -y $PACKAGE
if [ "$PACKAGE" = "$ORG_PKG" ]; then
 systemctl enable mongod.service
fi
# Listening on all interfaces
sed -i 's/127.0.0.1/0.0.0.0/' $CONF
