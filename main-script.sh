#!/bin/bash

/CyberPatriot-Linux-Tools/firewall.sh
/CyberPatriot-Linux-Tools/media-detector.sh
/CyberPatriot-Linux-Tools/backup.sh
/CyberPatriot-Linux-Tools/password-policy.sh
/CyberPatriot-Linux-Tools/usersec.sh

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/sysctl.conf /etc/sysctl.conf
sysctl -p

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/rsyslog.d/50-default.conf /etc/rsyslog.d/50-default.conf
#Sets Up Proper Logging

#runs auditctl auditing
apt-get install auditd -y

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/audit/audit.rules /etc/audit/audit.rules
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/audit/auditd.conf /etc/audit/auditd.conf

auditctl -e 1

systemctl start rsyslog

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL MALICIOUS ALIAS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

alias  >> /CyberPatriot-Linux-Tools/results

echo "-------------------" >> /CyberPatriot-Linux-Tools/results
echo "CRONTABS FOR USERS!" >> /CyberPatriot-Linux-Tools/results
echo "-------------------" >> /CyberPatriot-Linux-Tools/results

for user in $(cut -f1 -d: /etc/passwd); do crontab -u $user -l; done >> /CyberPatriot-Linux-Tools/results

#Find any host based authentication files

echo "--------------------------------" >> /CyberPatriot-Linux-Tools/results
echo "HOST BASED AUTH FILES DETECTED!" >> /CyberPatriot-Linux-Tools/results
echo "--------------------------------" >> /CyberPatriot-Linux-Tools/results

sudo find / -name '*.shosts' >> /CyberPatriot-Linux-Tools/results

find / -name shosts.equiv >> /CyberPatriot-Linux-Tools/results

echo "----------------" >> /CyberPatriot-Linux-Tools/results
echo "UNSAFE PACKAGES!" >> /CyberPatriot-Linux-Tools/results
echo "----------------" >> /CyberPatriot-Linux-Tools/results

dpkg -l | grep tftpd-hpa  >> /CyberPatriot-Linux-Tools/results
dpkg -l | egrep -i 'ftpd' | egrep -v 'tftpd' >> /CyberPatriot-Linux-Tools/results
dpkg -l | grep  rsh-server >> /CyberPatriot-Linux-Tools/results
dpkg -l | grep nis >> /CyberPatriot-Linux-Tools/results
dpkg -l | grep telnetd >> /CyberPatriot-Linux-Tools/results

echo "---------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL PROMISC NIC!" >> /CyberPatriot-Linux-Tools/results
echo "----------------------" >> /CyberPatriot-Linux-Tools/results

ip link | grep -i promisc  >> /CyberPatriot-Linux-Tools/results