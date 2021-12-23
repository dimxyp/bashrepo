#!/bin/sh 
#dimitris.xypolias@kyndryl.com  
#git@github.com:dxfullv2/bashrepo/esxruleset 
#wget -O - https://raw.githubusercontent.com/dxfullv2/bashrepo/Log4j/ansible-log4j/install.sh | sh
echo " ========================== "
echo "Ansible playbook preparation"
echo "Download and unzip Kyndryl's scanners on /[installpath]/scan/"
#echo "Download VMware vcenter fix on /[installpath]/fix/"
echo "Prepare WinOS if needed using /[installpath]/scan/ConfigureRemotingForAnsible.ps1"
echo " ========================== "
echo "Extra packages: git, pexpect, sshpass"
read -n 1 -r -s -p "Are you sure? Press any key to continue..." </dev/tty
mkdir /opt/Log4j/
cd /opt/Log4j/
read -e -p "Please enter playbook location ["/opt/Log4j"] : " -i "/opt/Log4j/" path </dev/tty
git clone -b Log4j https://github.com/dxfullv2/bashrepo.git
mv /opt/Log4j/bashrepo/ansible-log4j/* $path
rm /opt/Log4j/bashrepo/* -rf
#cd $path/fix/
#wget https://kb.vmware.com/sfc/servlet.shepherd/version/download/0685G00000d7ovWQAQ 
