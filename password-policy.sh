
#Account lockout policy



#setting up pam-cracklib
#apt-get install libpam-cracklib -y DECAPRECATED FUNCTION

apt-get install libpam-pwquality -y

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/login.defs /etc/login.defs
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc-pam.d/pam.d/common-password /etc/pam.d/common-password
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc-pam.d/pam.d/common-auth /etc/pam.d/common-auth