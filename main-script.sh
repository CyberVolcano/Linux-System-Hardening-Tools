#!/bin/bash

/CyberPatriot-Linux-Tools/firewall.sh
/CyberPatriot-Linux-Tools/media-detector.sh
/CyberPatriot-Linux-Tools/backup.sh
/CyberPatriot-Linux-Tools/password-policy.sh

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

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/sysctl.conf /etc/sysctl.conf
sysctl -p

awk -F: '($2 == "") {print}' /etc/shadow

#runs auditctl auditing
apt-get install auditd -y
auditctl -e 1

echo "-------------------" >> /CyberPatriot-Linux-Tools/results
echo "CRONTABS FOR USERS!" >> /CyberPatriot-Linux-Tools/results
echo "-------------------" >> /CyberPatriot-Linux-Tools/results
for user in $(cut -f1 -d: /etc/passwd); do crontab -u $user -l; done >> /CyberPatriot-Linux-Tools/results
