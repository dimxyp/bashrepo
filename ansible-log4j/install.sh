#!/bin/sh 
#dimitris.xypolias@kyndryl.com  
#git@github.com:dxfullv2/bashrepo/esxruleset 
#wget -O - https://raw.githubusercontent.com/dxfullv2/bashrepo/Log4j/ansible-log4j/install.sh | sh
mkdir /opt/Log4j/
cd /opt/Log4j/
git clone -b Log4j --single-branch https://github.com/dxfullv2/bashrepo.git
