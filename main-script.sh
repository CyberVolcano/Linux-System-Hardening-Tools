#!/bin/bash

#Sets Up Proper Logging

#runs auditctl auditing
apt-get install auditd -y

systemctl enable auditd
systemctl start auditd

/CyberPatriot-Linux-Tools/backup.sh

/CyberPatriot-Linux-Tools/network-security.sh
/CyberPatriot-Linux-Tools/media-detector.sh

/CyberPatriot-Linux-Tools/password-policy.sh
/CyberPatriot-Linux-Tools/usersec.sh
/CyberPatriot-Linux-Tools/backdoors-rootkits-detector.sh
/CyberPatriot-Linux-Tools/file-perms.sh
/CyberPatriot-Linux-Tools/apparmor.sh
/CyberPatriot-Linux-Tools/updates.sh

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/sysctl.conf /etc/sysctl.conf
sysctl -p

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/rsyslog.d/50-default.conf /etc/rsyslog.d/50-default.conf

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/audit/audit.rules /etc/audit/audit.rules
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/audit/auditd.conf /etc/audit/auditd.conf

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/security/limits.conf /etc/security/limits.conf

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

#Locking down Crontab to root

echo root > /etc/cron.allow
echo root > /etc/at.allow

if [ -f "/etc/cron.deny" ]; then
   rm cron.deny
fi

if [ -f "/etc/at.deny" ]; then
   rm at.deny
fi

#Find any host based authentication files

echo "--------------------------------" >> /CyberPatriot-Linux-Tools/results
echo "HOST BASED AUTH FILES DETECTED!" >> /CyberPatriot-Linux-Tools/results
echo "--------------------------------" >> /CyberPatriot-Linux-Tools/results

sudo find / -xdev -name '*.shosts' >> /CyberPatriot-Linux-Tools/results

find / -xdev -name shosts.equiv >> /CyberPatriot-Linux-Tools/results

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

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/bashrc /etc/bashrc
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/profile /etc/profile

echo "---------------------" >> /CyberPatriot-Linux-Tools/results
echo "CHECK FOR SHELLSHOCK VULNERABILITY!" >> /CyberPatriot-Linux-Tools/results
echo "----------------------" >> /CyberPatriot-Linux-Tools/results

env VAR='() { :;}; echo Bash is vulnerable!' bash -c "echo Bash is not vulnerable" >> results.txt

################################################################################################

passwd -l root

usermod -s /sbin/nologin root

#Lock out root account and change shell

usermod -g 0 root

#Change root GID to 0

################################################################################################

# Disable Automounting
echo "blacklist autofs" >> /etc/modprobe.d/blacklist.conf

#Set FireFox as default browser
update-alternatives --set x-www-browser /usr/bin/firefox

################################################################################################

#Lockout computer after a certain amount of time

#gsettings set org.gnome.desktop.session idle-delay 800
#gsettings set org.gnome.desktop.screensaver lock-delay 0 
#gsettings set org.gnome.desktop.screensaver lock-enabled true

#Remove information about our operating system on login prompts

################################################################################################

echo "Nothing Here!" > /etc/issue
echo "Nothing Here!" > /etc/issue.net
echo "Nothing Here!" > /etc/motd


################################################################################################
# ADDONS
################################################################################################

echo "install cramfs /bin/true" >> /etc/modprobe.d/CIS.conf
echo "install freevxfs /bin/true" >> /etc/modprobe.d/CIS.conf
echo "install jffs2 /bin/true" >> /etc/modprobe.d/CIS.conf
echo "install hfs /bin/true" >> /etc/modprobe.d/CIS.conf
echo "install hfsplus /bin/true" >> /etc/modprobe.d/CIS.conf
echo "install squashfs /bin/true" >> /etc/modprobe.d/CIS.conf
echo "install udf /bin/true" >> /etc/modprobe.d/CIS.conf
echo "install vfat /bin/true" >> /etc/modprobe.d/CIS.conf

################################################################################################

echo "install dccp /bin/true" >> /etc/modprobe.d/CIS.conf
echo "install sctp /bin/true" >> /etc/modprobe.d/CIS.conf
echo "install rds /bin/true" >> /etc/modprobe.d/CIS.conf
echo "install tipc /bin/true" >> /etc/modprobe.d/CIS.conf

################################################################################################

#"Setting Sticky bit on all world-writable directories"

df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type d -perm -0002 2>/dev/null | xargs chmod a+t

#"Core Dumping Process Hardening"
echo "* hard core 0" >> /etc/security/limits.conf

################################################################################################

#Disable compilers

chmod 000 /usr/bin/as >/dev/null 2>&1
chmod 000 /usr/bin/byacc >/dev/null 2>&1
chmod 000 /usr/bin/yacc >/dev/null 2>&1
chmod 000 /usr/bin/bcc >/dev/null 2>&1
chmod 000 /usr/bin/kgcc >/dev/null 2>&1
chmod 000 /usr/bin/cc >/dev/null 2>&1
chmod 000 /usr/bin/gcc >/dev/null 2>&1
chmod 000 /usr/bin/*c++ >/dev/null 2>&1
chmod 000 /usr/bin/*g++ >/dev/null 2>&1

#Configure umask - Newly created file permissions

umask 0027

#Disable USB storage

echo "install usb-storage /bin/true" > /etc/modprobe.d/usb-storage.conf

#Hide processes from regular users

cp -f /etc/fstab /CyberPatriot-Linux-Tools/old_files
echo "" /> /etc/fstab
echo "mount -o remount,rw,nosuid,nodev,noexec,relatime,hidepid=2 /proc" >> /etc/fstab

# Securing /tmp directory

chmod 1777 /tmp

#logon access

echo "readonly TMOUT=900" >> /etc/profile.d/idle-users.sh
echo "readonly HISTFILE" >> /etc/profile.d/idle-users.sh
chmod +x /etc/profile.d/idle-users.sh

# Securing SUID commands

chmod a-s /usr/bin/chage
chmod a-s /usr/bin/gpasswd
chmod a-s /usr/bin/wall
chmod a-s /usr/bin/chfn
chmod a-s /usr/bin/chsh
chmod a-s /usr/bin/newgrp
chmod a-s /usr/bin/write
chmod a-s /bin/ping
chmod a-s /bin/mount
chmod a-s /bin/umount

# Disable core dumps
echo 'ulimit -S -c 0 > /dev/null 2>&1' >> /etc/profile

# Disallow Root login

echo "" > /etc/securetty

# Exit 0 rc.local

echo "0" > rc.local

# MAKE SURE TO MAKE SURE THAT OUR USERS AND GROUPS ARE SETUP PROPERLY

#Configure the system to disable the Ctrl-Alt-Delete sequence for the command line with the following command:

sudo systemctl mask ctrl-alt-del.target
sudo systemctl daemon-reload

#Disable Automatic USB Mounting

touch /etc/modprobe.d/usb-storage.conf
echo "install usb-storage /bin/true" > /etc/modprobe.d/usb-storage.conf

###############################################################
# Process Hiding
###############################################################

mount -o remount,rw,nosuid,nodev,noexec,relatime,hidepid=2 /proc

echo "proc    /proc    proc    defaults,nosuid,nodev,noexec,relatime,hidepid=2     0     0" >> /etc/fstab