
#Clears IPV4
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables -X

#Clears IPV6
ip6tables -P INPUT ACCEPT
ip6tables -P FORWARD ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -t nat -F
ip6tables -t mangle -F
ip6tables -F
ip6tables -X

iptables -A INPUT -p all -s localhost  -i eth0 -j DROP
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
iptables -A INPUT -f -j DROP

sudo systemctl enable ufw.service 
sudo systemctl start ufw.service
#ufw is a service so we have to enable it

ufw enable

ufw logging on
ufw logging full

#log ufw events

ufw status

#ufw deny 23 # TELNET
#ufw deny 22 # SSH
#ufw deny 21 # FTP
#ufw deny 515 # CUPS
#ufw deny 80 # APACHE
#ufw deny 3389 # REMOTE DESKTOP PROTOCOL
#ufw deny 139 # SAMBA

echo "Firewall Secured"

sudo echo "nospoof on" >> /etc/host.conf

cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/hosts.deny /etc/hosts.deny
cp -f /CyberPatriot-Linux-Tools/secure-configurations/etc/hosts.allow /etc/hosts.allow

#Hosts hardening

echo "ALL: 10.0.0.0/255.0.0.0" >> /etc/hosts.allow
echo "ALL: 192.168.0.0/255.255.0.0" >> /etc/hosts.allow
echo "ALL: 172.16.0.0/255.240.0.0" >> /etc/hosts.allow

#Turn off spoofing

sudo echo "nospoof on" >> /etc/host.conf