#!/bin/bash

/CyberPatriot-Linux-Tools/firewall.sh
/CyberPatriot-Linux-Tools/media-detector.sh
/CyberPatriot-Linux-Tools/backup.sh
/CyberPatriot-Linux-Tools/password-policy.sh
/CyberPatriot-Linux-Tools/usersec.sh
/CyberPatriot-Linux-Tools/backdoors-rootkits-detector.sh

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/sysctl.conf /etc/sysctl.conf
sysctl -p

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/rsyslog.d/50-default.conf /etc/rsyslog.d/50-default.conf

#Sets Up Proper Logging

#runs auditctl auditing
apt-get install auditd -y

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/audit/audit.rules /etc/audit/audit.rules
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/audit/auditd.conf /etc/audit/auditd.conf

auditctl -e 1

systemctl enable rsyslog
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

apt list tftpd-hpa  >> /CyberPatriot-Linux-Tools/results
apt list ftpd >> /CyberPatriot-Linux-Tools/results
apt list tftpd >> /CyberPatriot-Linux-Tools/results
apt list rsh-server >> /CyberPatriot-Linux-Tools/results
apt list nis >> /CyberPatriot-Linux-Tools/results
apt list telnetd >> /CyberPatriot-Linux-Tools/results

echo "---------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL PROMISC NIC!" >> /CyberPatriot-Linux-Tools/results
echo "----------------------" >> /CyberPatriot-Linux-Tools/results

ip link | grep -i promisc  >> /CyberPatriot-Linux-Tools/results

echo "---------------------" >> /CyberPatriot-Linux-Tools/results
echo "SUSPICIOUS PROGRAMS!" >> /CyberPatriot-Linux-Tools/results
echo "---------------------" >> /CyberPatriot-Linux-Tools/results

SuspiciousPrograms=('nmap','wireshark','john','john-data','hydra','hydra-gtk','aircrack-ng','fcrackzip','lcrack','ophcrack','ophcrack-cli','pdfcrack','pyrit','rarcrack','sipcrack','irpas','logkeys','nikto','medusa','kismet','kismet-plugins','wifite','slowhttptest')

for program in "${SuspiciousPrograms[@]}"; do
	dpkg -s $program &> /dev/null  
	if [ $? -ne 0 ]
	then
		echo $program "not installed"  
	else
		echo $program "DETECTED!" >> /CyberPatriot-Linux-Tools/results
	fi
done

echo "---------------------" >> /CyberPatriot-Linux-Tools/results
echo "CHECK FOR SHELLSHOCK VULNERABILITY!" >> /CyberPatriot-Linux-Tools/results
echo "----------------------" >> /CyberPatriot-Linux-Tools/results

env VAR='() { :;}; echo Bash is vulnerable!' bash -c "echo Bash is not vulnerable"
echo "sudo apt-get update && sudo apt-get install --only-upgrade bash" 

passwd -l root
usermod -s /sbin/nologin root
#Lock out root account and change shell

# Disable Automounting
update-rc.d autofs disable

#Set FireFox as default browser
update-alternatives --set x-www-browser /usr/bin/firefox

#Lockout computer after a certain amount of time

gsettings set org.gnome.desktop.session idle-delay 800
gsettings set org.gnome.desktop.screensaver lock-delay 0 
gsettings set org.gnome.desktop.screensaver lock-enabled true

#Remove information about our operating system on login prompts

echo "Nothing Here!" > /etc/issue
echo "Nothing Here!" > /etc/issue.net
echo "Nothing Here!" > /etc/motd