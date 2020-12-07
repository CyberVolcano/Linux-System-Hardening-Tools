chown root:root /etc/passwd
chmod 644 /etc/passwd

chown root:shadow /etc/shadow
chmod o-rwx,g-wx /etc/shadow

chown root:root /etc/group
chmod 644 /etc/group

chown root:shadow /etc/gshadow
chmod o-rwx,g-rw /etc/gshadow

chown root:root /etc/passwd-
chmod u-x,go-wx /etc/passwd-

chown root:root /etc/shadow-
chown root:shadow /etc/shadow-
chmod o-rwx,g-rw /etc/shadow-

chown root:root /etc/group-
chmod u-x,go-wx /etc/group-

chown root:root /etc/gshadow-
chown root:shadow /etc/gshadow-

chmod o-rwx,g-rw /etc/gshadow-

chown root:root /boot/grub/grub.cfg
chmod og-rwx /boot/grub/grub.cfg

chown root:root /etc/issue
chmod 644 /etc/issue

if [ -f "/etc/motd" ]; then
	chown root:root /etc/motd
	chmod 644 /etc/motd
fi

chown root:root /etc/issue.net
chmod 644 /etc/issue.net

chown root:root /etc/hosts.allow
chmod 644 /etc/hosts.allow

chown root:root /etc/hosts.deny
chmod 644 /etc/hosts.deny

chmod -R g-wx,o-rwx /var/log/*

chown root:root /etc/crontab
chmod og-rwx /etc/crontab

chown root:root /etc/cron.hourly
chmod og-rwx /etc/cron.hourly

chown root:root /etc/cron.daily
chmod og-rwx /etc/cron.daily

chown root:root /etc/cron.weekly
chmod og-rwx /etc/cron.weekly

chown root:root /etc/cron.monthly
chmod og-rwx /etc/cron.monthly

chown root:root /etc/cron.d
chmod og-rwx /etc/cron.d

touch /etc/cron.allow
touch /etc/at.allow
chmod og-rwx /etc/cron.allow
chmod og-rwx /etc/at.allow
chown root:root /etc/cron.allow
chown root:root /etc/at.allow