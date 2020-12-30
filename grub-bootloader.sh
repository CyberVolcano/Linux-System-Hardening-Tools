grub-mkpasswd-pbkdf2 | tee grubpassword.tmp
grubpassword=$(cat grubpassword.tmp | sed -e '1,2d' | cut -d ' ' -f7)
echo " set superusers="root" " >> /etc/grub.d/40_custom
echo " password_pbkdf2 root $grubpassword " >> /etc/grub.d/40_custom
rm grubpassword.tmp
update-grub

#NOT SET YET