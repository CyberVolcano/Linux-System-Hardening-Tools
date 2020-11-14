cp -f /etc/ssh/sshd_config /CyberPatriot-Linux-Tools/old_files
cp -f /CyberPatriot-Linux-Tools/secure-configurations/sshd_config /etc/ssh/sshd_config

sudo ufw limit ssh