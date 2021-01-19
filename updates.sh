cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/apt-apt.conf.d/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/apt-apt.conf.d/20auto-upgrades  /etc/apt/apt.conf.d/20auto-upgrades
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/apt-apt.conf.d/release-upgrades /etc/apt/apt.conf.d/release-upgrades

cp -rf /etc/apt/sources.list.d /CyberPatriot-Linux-Tools/old_files

sudo apt install python-software-properties
sudo add-apt-repository ppa:libreoffice/ppa
#Installs libreoffice repository

apt install unattended-upgrades -y

#Tool Reinstallation

apt install -y --reinstall net-tools
apt install -y --reinstall coreutils

dpkg-reconfigure --priority=low unattended-upgrades