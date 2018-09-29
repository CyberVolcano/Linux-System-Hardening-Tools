#!/bin/bash

#Sorts users and alerts of rogue users

#BACKUP cat /etc/passwd | grep "/bin/bash" |  cut -f1 -d":" > /root/Desktop/list_of_users


iptables -A INPUT -p all -s localhost  -i eth0 -j DROP
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
iptables -A INPUT -f -j DROP

ufw enable

ufw logging high

ufw status

ufw deny 23 # TELNET
ufw deny 22 # SSH
ufw deny 21 # FTP
ufw deny 515 # CUPS
ufw deny 80 # APACHE
ufw deny 3389 # REMOTE DESKTOP PROTOCOL
ufw deny 139 # SAMBA

ufw status


cat /etc/passwd | grep "/home" |  cut -f1 -d":" > $PWD/Desktop/list_of_users

input="$PWD/Desktop/list_of_users"

while IFS= read -r var
do
  if [[ $(grep $var $PWD/Desktop/approved_users) ]]; then
    :
 else
    echo $var " is an unapproved user!"
 fi
done < "$input"


if [[ $(lsb_release -a| grep "Xenial") ]]; then

	echo "Ubuntu 16 Detected"
	sudo sh -c 'printf "[Seat:*]\nallow-guest=false\n" >/etc/lightdm/lightdm.conf.d/50-no-guest.conf'
else

	echo "Ubuntu 14 Detected"
	sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'
fi

lightdm restart

echo "Searching for world writable files"

find /dir -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print

echo "PROMPT=no" >> /etc/sysconfig/init

awk -F: '($2 == "") {print}' /etc/shadow

service --status-all | grep "ftp"
service --status-all | grep "ssh"
service --status-all | grep "rdp"

faillog -m 8

sysctl --system