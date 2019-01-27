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

echo "-----------------" >> /CyberPatriot-Linux-Tools/results
echo "UNAPPROVED USERS!" >> /CyberPatriot-Linux-Tools/results
echo "-----------------" >> /CyberPatriot-Linux-Tools/results

cat /etc/passwd | grep "/bin/bash" |  cut -f1 -d":" > /CyberPatriot-Linux-Tools/list_of_users

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


echo "allow-guest=false" >> /etc/lightdm/lightdm.conf

#echo "PROMPT=no" >> /etc/sysconfig/init

awk -F: '($2 == "") {print}' /etc/shadow



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
#ok
#Makes copies of old files
cp -f /etc/pam.d/common-password /CyberPatriot-Linux-Tools/old_files
cp -f /etc/pam.d/common-auth /CyberPatriot-Linux-Tools/old_files
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc-pam.d/pam.d/common-password /etc/pam.d/common-password
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc-pam.d/pam.d/common-auth /etc/pam.d/common-auth
#Account lockout policy
sudo faillog -m 10

cp -f /etc/sysctl.conf /CyberPatriot-Linux-Tools/old_files/
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/sysctl.conf /etc/sysctl.conf
sysctl -p

cp -f /etc/login.defs /CyberPatriot-Linux-Tools/old_files
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/login.defs /etc/login.defs

#setting up pam-cracklib
apt-get install libpam-cracklib -y

#runs auditctl auditing
apt-get install auditd -y
auditctl -e 1

echo "-------------------" >> /CyberPatriot-Linux-Tools/results
echo "CRONTABS FOR USERS!" >> /CyberPatriot-Linux-Tools/results
echo "-------------------" >> /CyberPatriot-Linux-Tools/results
for user in $(cut -f1 -d: /etc/passwd); do crontab -u $user -l; done >> /CyberPatriot-Linux-Tools/results
