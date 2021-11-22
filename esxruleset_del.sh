#!/bin/sh
#dimitris.xypolias@kyndryl.com 
#git@github.com:dxfullv2/bashrepo/esxruleset 
#wget -O - https://raw.githubusercontent.com/dxfullv2/bashrepo/main/esxruleset_del.sh | sh
echo ""
echo "================================================================="
echo "================================================================="
echo "The following script removes prompt subnet for all ESXi firewall." 
echo "================================================================="
echo "================================================================="
echo ""
sleep 2
echo ""
read -p "Enter First Blocked Subnet [a.b.c.d/e]: " sub1 </dev/tty
read -p "Enter Second Blocked Subnet [a.b.c.d/e]: " sub2 </dev/tty
echo ""
read -n 1 -r -s -p "Are you sure? Press any key to continue..." </dev/tty
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
esxcli network firewall ruleset allowedip remove -r=$srv -i=$sub1
esxcli network firewall ruleset allowedip remove -r=$srv -i=$sub2
done
rm /tmp/rules
echo ""
echo "Done, keep safe!"
