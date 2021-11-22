#!/bin/bash 
#dimitris.xypolias@kyndryl.com 
#git@github.com:dxfullv2/bashrepo/esxruleset 
#wget -O - https://raw.githubusercontent.com/dxfullv2/bashrepo/main/esxruleset.sh | sh
read -p "Enter First Allowed Subnet [a.b.c.d/e]: " sub1
read -p "Enter Second Allowed Subnet [a.b.c.d/e]: " sub2
echo "=================================================="
echo "The following script enable firewall blocking for all ESXi services, except SSHServer, above subnets will be excluded from blocking"
read -n 1 -r -s -p "Are you sure? Press any key to continue..."
echo $(esxcli network firewall ruleset list) > /tmp/rules
sed -i 's/true//g; s/false//g; s/Name Enabled ---------------------- -------//g; s/sshServer//g; s/ /\n/g' /tmp/rules
sed -i ' /^$/d ' /tmp/rules
rls=$(cat /tmp/rules)
for srv in $rls
do
esxcli network firewall ruleset set -r=$srv --allowed-all false
done
for srv in $rls
do
esxcli network firewall ruleset allowedip add -r=$srv -i=$sub1
esxcli network firewall ruleset allowedip add -r=$srv -i=$sub2
done
rm /tmp/rules
echo "Do you want to continue blocking SSH access?"
read -n 1 -r -s -p "Are you sure? Press any key to continue..."
esxcli network firewall ruleset set -r=sshServer --allowed-all false
esxcli network firewall ruleset allowedip add -r=sshServer -i=$sub1
esxcli network firewall ruleset allowedip add -r=sshServer -i=$sub2
echo "Done, keep safe!"
