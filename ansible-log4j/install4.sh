#!/bin/sh 
#dimitris.xypolias@kyndryl.com  
#git@github.com:dxfullv2/bashrepo/esxruleset 
#wget -O - https://raw.githubusercontent.com/dxfullv2/bashrepo/Log4j/ansible-log4j/install.sh | sh
echo ""
read -n 1 -r -s -p "Are you sure? Press any key to continue..." </dev/tty
mkdir /opt/Log4j/
cd /opt/Log4j/
read -e -p "Please enter playbook location ["/opt/Log4j"] : " -i "/opt/Log4j/" path </dev/tty
git clone -b Log4j https://github.com/dxfullv2/bashrepo.git
mv /opt/Log4j/bashrepo/ansible-log4j/* $path
rm /opt/Log4j/bashrepo/* -rf
