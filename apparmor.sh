
systemctl enable apparmor.service
systemctl start apparmor.service

apt-get install libpam-apparmor

sudo apt install apparmor apparmor-profiles apparmor-utils

#INSTALL APPARMOR PROFILES

sudo aa-enforce /etc/apparmor.d/*

#ENFORCE APP ARMOR PROFILES^