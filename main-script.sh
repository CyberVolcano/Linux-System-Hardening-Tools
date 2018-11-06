#!/bin/bash

#Sorts users and alerts of rogue users

#BACKUP cat /etc/passwd | grep "/bin/bash" |  cut -f1 -d":" > /root/Desktop/list_of_users

#Clears IPV4
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables -X

#Clears IPV6
ip6tables -P INPUT ACCEPT
ip6tables -P FORWARD ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -t nat -F
ip6tables -t mangle -F
ip6tables -F
ip6tables -X



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

echo"-----------------" >> /CyberPatriot-Linux-Tools/results
echo"UNAPPROVED USERS!" >> /CyberPatriot-Linux-Tools/results
echo"-----------------" >> /CyberPatriot-Linux-Tools/results

cat /etc/passwd | grep "/home" |  cut -f1 -d":" > /CyberPatriot-Linux-Tools/list_of_users

input="/CyberPatriot-Linux-Tools/list_of_users"

while IFS= read -r var
do
  if [[ $(grep $var /CyberPatriot-Linux-Tools/approved_users) ]]; then
    :
 else
    echo $var " is an unapproved user!"
    echo $var " is an unapproved user!" >> /CyberPatriot-Linux-Tools/results
 fi
done < "$input"


if [[ $(lsb_release -a| grep "Xenial") ]]; then

  echo "Ubuntu 16 Detected"
  sudo sh -c 'printf "[Seat:*]\nallow-guest=false\n" >/etc/lightdm/lightdm.conf.d/50-no-guest.conf'
else

  echo "Ubuntu 14 Detected"
  sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'
fi


echo "Searching for world writable files"

find / -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print

echo "PROMPT=no" >> /etc/sysconfig/init

awk -F: '($2 == "") {print}' /etc/shadow

echo "---------------------" >> /CyberPatriot-Linux-Tools/results
echo "UNAPPROVED SERVICES!" >> /CyberPatriot-Linux-Tools/results
echo "--------------------" >> /CyberPatriot-Linux-Tools/results

service --status-all | grep "ftp" >> /CyberPatriot-Linux-Tools/results
service --status-all | grep "ssh" >> /CyberPatriot-Linux-Tools/results
service --status-all | grep "rdp" >> /CyberPatriot-Linux-Tools/results

#faillog -m 8

#sysctl --system

echo "-----------------------" >> /CyberPatriot-Linux-Tools/results
echo "UNAPPROVED MEDIA FILES!" >> /CyberPatriot-Linux-Tools/results
echo "-----------------------" >> /CyberPatriot-Linux-Tools/results

find / -name '*.mp3' -type f -not -path "/usr/*" >> /CyberPatriot-Linux-Tools/results
find / -name '*.mov' -type f -not -path "/usr/*" >> /CyberPatriot-Linux-Tools/results
find / -name '*.mp4' -type f -not -path "/usr/*" >> /CyberPatriot-Linux-Tools/results
find / -name '*.avi' -type f -not -path "/usr/*" >> /CyberPatriot-Linux-Tools/results
find / -name '*.mpg' -type f -not -path "/usr/*" >> /CyberPatriot-Linux-Tools/results
find / -name '*.mpeg' -type f -not -path "/usr/*" >> /CyberPatriot-Linux-Tools/results
find / -name '*.flac' -type f -not -path "/usr/*" >> /CyberPatriot-Linux-Tools/results
find / -name '*.m4a' -type f -not -path "/usr/*" >> /CyberPatriot-Linux-Tools/results
find / -name '*.flv' -type f -not -path "/usr/*" >> /CyberPatriot-Linux-Tools/results
find / -name '*.ogg' -type f -not -path "/usr/share/*" >> /CyberPatriot-Linux-Tools/results
find / -name '*.gif' -type f -not -path "/usr/*" >> /CyberPatriot-Linux-Tools/results
find / -type f -name "*.png" ! -path "/lib/*" ! -path "/usr/*" >> /CyberPatriot-Linux-Tools/results
find / -name '*.jpg' -type f -not -path "/usr/*" >> /CyberPatriot-Linux-Tools/results
find / -name '*.jpeg' -type f -not -path "/usr/*" >> /CyberPatriot-Linux-Tools/results

# ^ Work in progress on removing false red alarms

#cp -f $PWD/Desktop /etc/sysctl.d/10-network-security.conf /etc/sysctl.d/10-network-security.conf-old
#cp -f /CyberPatriot-Linux-Tools-master/etc-pam.d/pam.d/common-password /etc/pam.d/common-password

#!/bin/bash
 
#read -r -p "Are You Sure? [Y/n] " input
 
#case $input in
 #   [yY][eE][sS]|[yY])
 #lightdm restart
 #;;
 
 #   [nN][oO]|[nN])
 #echo "Script Stopped"
  #     ;;
 
   # *)
 #echo "Invalid input..."
 #exit 1
 #;;
#esac