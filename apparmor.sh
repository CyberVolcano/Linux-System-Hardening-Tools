
systemctl enable apparmor.service
systemctl start apparmor.service

apt install libpam-apparmor

sudo apt install apparmor apparmor-profiles apparmor-utils -y

#INSTALL APPARMOR PROFILES

sudo aa-enforce /etc/apparmor.d/*

#ENFORCE APP ARMOR PROFILES^