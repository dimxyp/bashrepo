#!/bin/sh
# added  .bash_profile
# touch /root/firstrun
# passd -d root
# touch ~/.hushlogin
# /lib/systemd/system/getty@.service  | ExecStart=-/sbin/agetty --noclear -a root %I $TERM
func_pass () {
 read -s -rep $'Please enter root password :\n' PASS </dev/tty
 read -s -rep $'Please enter again :\n' PASS2 </dev/tty
}
touch /var/lock/subsys/local
plymouth quit
if [ -f "/root/firstrun" ]
then
    nic=$(ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}')
    echo "==================================================="
    echo -ne "\x1b[32m"
    echo "Ansible AIC Standalone Server"
    echo -ne "\x1b[0m"
    echo "==================================================="
    echo -ne "\x1b[33m"
    echo "Setup the hostname of the server"
    echo -ne "\x1b[0m"
    echo "==================================================="
    read -e -p "Please enter hostname : " NAME </dev/tty   
    func_pass
    if [ $PASS != $PASS2 ] 
    then
        echo -ne "\x1b[31m"
        echo "Password does not match, Try again."
        echo -ne "\x1b[0m"
        func_pass
        sleep 1
    else 
    echo "==================================================="
     echo -ne "\x1b[33m"
    echo "Ethernet device$nic Configuration"
    echo -ne "\x1b[0m"
    echo "==================================================="
    read -e -p "Please enter IP address : " IP </dev/tty
    read -e -p "Please enter CIDR : " -i "24" MASK </dev/tty
    read -e -p "Please enter Gateway : " GATEWAY </dev/tty
    read -e -p "Please enter DNS : " DNS </dev/tty
    echo "==================================================="
    echo -ne "\x1b[33m"
    echo "AIC Standalone Configuration"
    echo -ne "\x1b[0m"
    echo "==================================================="
    read -e -p "Please enter AIC Three Code : " TCODE </dev/tty
    echo "New hostanme: $NAME, Passwor is set and AIC Three Code: $TCODE"
    echo "New IP: $IP/$MASK using $GATEWAY as Gateway and $DNS as DNS Server"
    echo ""
    echo "Are you sure everything is ok? (y/n):    "
    read answer
    if [ $answer == y ]
    then
        echo -n "Change Hostname..."
        sed -i '/HOSTNAME/c\' /etc/sysconfig/network
        echo "HOSTNAME=$NAME" >> /etc/sysconfig/network
        echo $NAME > /etc/hostname
        hostname $NAME
        hostnamectl set-hostname $NAME
        echo -e "\x1b[32m[OK]"; echo -ne "\x1b[0m"
        echo $PASS | passwd --stdin root 
        echo -n "Configure root Password..."
        echo -e "\x1b[32m[OK]"; echo -ne "\x1b[0m"
        echo -n "Configure Network..."
	    # nmcli connection modify $nic IPv4.address $IP/$MASK
        # nmcli connection modify $nic IPv4.gateway $GATEWAY
        # nmcli connection modify $nic IPv4.dns $DNS
        # make the interface up and restart the service
        echo -e "\x1b[32m[OK]"; echo -ne "\x1b[0m"
        echo -n "Restarting Network..."
        # nmcli device disconnect $nic
        # nmcli device connect $nic
        echo -e "\x1b[32m[OK]"; echo -ne "\x1b[0m"
        echo -n "Configure ThreeCode..."
        sed -i "s/TCODE/$TCODE/g" /root/AICstandalone/vars/main.yml
        echo -e "\x1b[32m[OK]"; echo -ne "\x1b[0m"  
        sleep 1
        echo -n "Configure CleanUp..."
        sed -i 's/-a root//g' /lib/systemd/system/getty@.service
        #rm -f /root/firstrun
        #mv -f /root/bootstrap.sh /tmp
        echo -e "\x1b[32m[OK]"; echo -ne "\x1b[0m"  
        echo ""
        echo "Network Output:"
        ip a | grep $nic
        echo "Server will be restarted, continue (y/n)"
        read rebanswer
        if [ $rebanswer == y ]
            then
            reboot
            else
            bash /root/bootstrap.sh
            fi
    else
        bash /root/bootstrap.sh
    fi
    fi
fi
