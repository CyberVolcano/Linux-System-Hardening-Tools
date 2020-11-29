
systemctl enable apparmor.service
systemctl start apparmor.service

apt-get install libpam-apparmor

sudo apt install apparmor-profiles

#INSTALL APPARMOR PROFILES

sudo aa-enforce /etc/apparmor.d/*

#ENFORCE APP ARMOR PROFILES^