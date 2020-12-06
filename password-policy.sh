
#Account lockout policy



#setting up pam-cracklib
#apt-get install libpam-cracklib -y DECAPRECATED FUNCTION

apt install -y libpam-pwquality
apt install -y libpam-modules


cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/login.defs /etc/login.defs
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc-pam.d/pam.d/common-password /etc/pam.d/common-password
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc-pam.d/pam.d/common-auth /etc/pam.d/common-auth
cp -f /CyberPatriot-Linux-Tools/security/pwquality.conf /etc/security/pwquality.conf
