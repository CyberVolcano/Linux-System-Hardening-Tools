cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/apt-apt.conf.d/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/apt-apt.conf.d/20auto-upgrades  /etc/apt/apt.conf.d/20auto-upgrades
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/apt-apt.conf.d/release-upgrades /etc/apt/apt.conf.d/release-upgrades
cp -f /CyberPatriot-Linux-Tools/secure-configurations/Ubuntu-16-Packages /etc/apt/sources.list

cp -f sources.list.d /CyberPatriot-Linux-Tools/old_files

sudo apt install python-software-properties
sudo add-apt-repository ppa:libreoffice/ppa
#Installs libreoffice repository

apt install unattended-upgrades -y

#Tool Reinstallation

apt install -y --reinstall net-tools
apt install -y --reinstall coreutils
apt install -y --reinstall mlocate
updatedb

dpkg-reconfigure --priority=low unattended-upgrades