#!/bin/sh
# added  .bash_profile
# touch /root/firstrun
# passd -d root
#

touch /var/lock/subsys/local
plymouth quit
if [ -f "/root/firstrun" ]
then
    nic=$(ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}')
    echo "==================================================="
    echo "Ansible AIC Standalone Server"
    echo "==================================================="
    echo "Setup the hostname of the server!"
    echo "==================================================="
    read -e -p "Please enter hostname : " NAME </dev/tty   
    echo "==================================================="
    echo "Ethernet device$nic Configuration!"
    echo "==================================================="
    read -e -p "Please enter IP address : " IP </dev/tty
    read -e -p "Please enter CIDR : " -i "24" MASK </dev/tty
    read -e -p "Please enter Gateway : " GATEWAY </dev/tty
    read -e -p "Please enter DNS : " DNS </dev/tty
    echo ""  
    echo "New IP: $IP/$MASK using $GATEWAY as Gateway and $DNS as DNS Server"
    echo "Are you sure everything is ok? (y/n):    "
    read answer
    if [ $answer == y ]
    then
        # change hostname
        sed -i '/HOSTNAME/c\' /etc/sysconfig/network
        echo "HOSTNAME=$NAME" >> /etc/sysconfig/network
        echo $NAME > /etc/hostname
        hostname $NAME
        hostnamectl set-hostname $NAME
        # Configure network
	    # nmcli connection modify $nic IPv4.address $IP/$MASK
        # nmcli connection modify $nic IPv4.gateway $GATEWAY
        # nmcli connection modify $nic IPv4.dns $DNS
        # make the interface up and restart the service
        echo "Restarting the Network Service, please wait!"
        # nmcli device disconnect $nic
        # nmcli device connect $nic
        sleep 1
        echo ""
        echo "==================================================="
        echo "AIC Standalone Configuration"
        echo "==================================================="
        read -e -p "Please enter AIC Three Code : " TCODE </dev/tty
        sed -i "s/TCODE/$TCODE/g" /root/AICstandalone/vars/main.yml
        
        # echo "Output of network"
        # echo "==================================================="
        # ip a | grep $nic
        # echo "==================================================="
        #echo "Moving the script so that it won't execute again!"
        rm -f /root/firstrun
        mv -f /root/bootstrap.sh /tmp
        echo "Backup created at /tmp with name update.sh"
    else
        bash /root/bootstrap.sh
    fi
fi
