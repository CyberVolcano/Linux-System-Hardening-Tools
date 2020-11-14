
#Account lockout policy

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/login.defs /etc/login.defs
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc-pam.d/pam.d/common-password /etc/pam.d/common-password
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc-pam.d/pam.d/common-auth /etc/pam.d/common-auth
sudo faillog -m 10

#setting up pam-cracklib
apt-get install libpam-cracklib -y
apt-get install libpam-pwquality -y