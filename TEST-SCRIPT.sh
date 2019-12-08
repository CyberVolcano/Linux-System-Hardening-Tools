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

systemctl disable kdump.service #takes up alot of memory, may result in crash #76

apt-get install libpam-cracklib -y
apt-get install auditd -y
auditctl -e 1
sudo apt-get install aide

sudo chown root /var/log #ROOT OWNS LOG
sudo chgrp syslog /var/log #VAR LOG IS OWNED BY SYSLOG
sudo chmod 0770 /var/log #Change VAR/LOG to authorized personel
sudo chgrp adm /var/log/syslog

#Makes copies of old files
cp -f /etc/pam.d/common-password /CyberPatriot-Linux-Tools/old_files
cp -f /etc/pam.d/common-auth /CyberPatriot-Linux-Tools/old_files
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc-pam.d/pam.d/common-password /etc/pam.d/common-password
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc-pam.d/pam.d/common-auth /etc/pam.d/common-auth
#Account lockout policy
sudo faillog -m 10

cp -f /etc/security/limits.conf /CyberPatriot-Linux-Tools/old_files/
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/security/limits.conf /etc/security/limits.conf

cp -f /etc/security/pwquality.conf /CyberPatriot-Linux-Tools/old_files/
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/security/pwquality.conf /etc/security/pwquality.conf

cp -f /etc/sysctl.conf /CyberPatriot-Linux-Tools/old_files/
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/sysctl.conf /etc/sysctl.conf

sysctl -p

cp -f /etc/login.defs /CyberPatriot-Linux-Tools/old_files
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/login.defs /etc/login.defs

echo "-----------------" >> /CyberPatriot-Linux-Tools/results
echo "FINDING WORLD WRITABLE FILES" >> /CyberPatriot-Linux-Tools/results
echo "-----------------" >> /CyberPatriot-Linux-Tools/results

sudo find / -perm -2 -type d ! -group sys ! -group root ! -group bin -exec ls -lLd {} \; >> /CyberPatriot-Linux-Tools/results
echo "crash & metrics is ok">> /CyberPatriot-Linux-Tools/results

echo "-----------------" >> /CyberPatriot-Linux-Tools/results
echo "Configuring Updates" >> /CyberPatriot-Linux-Tools/results
echo "-----------------" >> /CyberPatriot-Linux-Tools/results

grep -i allowunauth /etc/apt/apt.conf.d/* >> /CyberPatriot-Linux-Tools/results

echo "Unattended-Upgrade::Remove-Unused-Dependencies \"true\";" > /etc/apt/apt.conf.d/50unattended-upgrades

echo "-----------------" >> /CyberPatriot-Linux-Tools/results
echo "DUPLICATE UIDS" >> /CyberPatriot-Linux-Tools/results
echo "-----------------" >> /CyberPatriot-Linux-Tools/results

awk -F ":" 'list[$3]++{print $1, $3}' /etc/passwd >> /CyberPatriot-Linux-Tools/results

echo "-----------------" >> /CyberPatriot-Linux-Tools/results
echo "CHECKING FOR OTHER UID OF 0" >> /CyberPatriot-Linux-Tools/results
echo "-----------------" >> /CyberPatriot-Linux-Tools/results

awk -F: '$3 == 0 {print $1}' /etc/passwd

echo "-----------------" >> /CyberPatriot-Linux-Tools/results
echo "WORLD WRITABLE FILES" >> /CyberPatriot-Linux-Tools/results
echo "-----------------" >> /CyberPatriot-Linux-Tools/results

sudo find / -perm -002 -type f -exec ls -ld {} \; >> /CyberPatriot-Linux-Tools/results
#73 check out
#DISA
# TURNS OFF USB 
echo “install usb-storage /bin/true” >> /etc/modprobe.d/usb-storage.conf

sudo systemctl stop autofs

#APPARMOR
apt-get install libpam-apparmor
systemctl enable apparmor.service
systemctl start apparmor.service

#CTRL ALT DEL
sudo systemctl mask ctrl-alt-del.target
sudo systemctl daemon-reload
touch cat /etc/dconf/db/local.d/00-disable-CAD

#echo "[org/gnome/settings-daemon/plugins/media-keys]"
#echo >> "logout=’’"
#Check if GNOME is installed

echo "-----------------" >> /CyberPatriot-Linux-Tools/results
echo "SHOSTS FOUND" >> /CyberPatriot-Linux-Tools/results
echo "-----------------" >> /CyberPatriot-Linux-Tools/results

find / -name '*.shosts' >> /CyberPatriot-Linux-Tools/results
find / -name shosts.equiv >> /CyberPatriot-Linux-Tools/results

echo "-----------------" >> /CyberPatriot-Linux-Tools/results
echo "APT Packages can be allowed unauthenticated below" >> /CyberPatriot-Linux-Tools/results
echo "-----------------" >> /CyberPatriot-Linux-Tools/results
grep -i allowunauth /etc/apt/apt.conf.d/* >> /CyberPatriot-Linux-Tools/results

echo "-----------------" >> /CyberPatriot-Linux-Tools/results
echo "Sudo Misconfigurations:" >> /CyberPatriot-Linux-Tools/results
echo "-----------------" >> /CyberPatriot-Linux-Tools/results

sudo egrep -i '(nopasswd|!authenticate)' /etc/sudoers /etc/sudoers.d/* >> /CyberPatriot-Linux-Tools/results

echo "-----------------" >> /CyberPatriot-Linux-Tools/results
echo "Nullok Accounts located" >> /CyberPatriot-Linux-Tools/results
echo "-----------------" >> /CyberPatriot-Linux-Tools/results
grep pam_unix.so /etc/pam.d/* >> /CyberPatriot-Linux-Tools/results

echo "This potentially means a user can login without a password"

ufw status

echo "Installing Vlock"

sudo apt-get install vlock

echo "Installing Auto-Lock out"
sudo touch /etc/profile.d/autologout.sh
echo "TMOUT=900" >> /etc/profile.d/autologout.sh
echo "readonly TMOUT" >> /etc/profile.d/autologout.sh
echo "export TMOUT" >> /etc/profile.d/autologout.sh

echo "-----------------" >> /CyberPatriot-Linux-Tools/results
echo "Package Status" >> /CyberPatriot-Linux-Tools/results
echo "-----------------" >> /CyberPatriot-Linux-Tools/results

/usr/lib/update-notifier/apt-check --human-readable >> /CyberPatriot-Linux-Tools/results

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

#setting up pam-cracklib
apt-get remove telnetd
apt-get remove rsh-server

echo "-------------------" >> /CyberPatriot-Linux-Tools/results
echo "CRONTABS FOR USERS!" >> /CyberPatriot-Linux-Tools/results
echo "-------------------" >> /CyberPatriot-Linux-Tools/results

for user in $(cut -f1 -d: /etc/passwd); do crontab -u $user -l; done >> /CyberPatriot-Linux-Tools/results
