cp /etc/pure-ftpd/conf /CyberPatriot-Linux-Tools/

rm /etc/pure-ftpd/conf/*

echo 'yes' > /etc/pure-ftpd/conf/ChrootEveryone

echo 'yes' > /etc/pure-ftpd/conf/BrokenClientsCompatibility

echo '50' > /etc/pure-ftpd/conf/MaxClientsNumber

echo '5' > /etc/pure-ftpd/conf/MaxClientsPerIP

echo 'yes' > /etc/pure-ftpd/conf/Daemonize

echo 'no' > /etc/pure-ftpd/conf/VerboseLog

echo 'yes' > /etc/pure-ftpd/conf/DisplayDotFiles

echo 'yes' > /etc/pure-ftpd/conf/ProhibitDotFilesWrite

echo 'yes' > /etc/pure-ftpd/conf/NoChmod

echo 'no' > /etc/pure-ftpd/conf/AnonymousOnly

echo 'yes' > /etc/pure-ftpd/conf/NoAnonymous

echo 'yes' > /etc/pure-ftpd/conf/PAMAuthentication

echo 'no' > /etc/pure-ftpd/conf/UnixAuthentication

echo '/etc/pure-ftpd/pureftpd.pdb' > /etc/pure-ftpd/conf/PureDB

echo 'yes' > /etc/pure-ftpd/conf/DontResolve

echo '15' > /etc/pure-ftpd/conf/MaxIdleTime

echo '2000 8' > /etc/pure-ftpd/conf/LimitRecursion

echo 'yes' > /etc/pure-ftpd/conf/AntiWarez

echo 'no' > /etc/pure-ftpd/conf/AnonymousCanCreateDirs

echo '4' > /etc/pure-ftpd/conf/MaxLoad

echo 'no' > /etc/pure-ftpd/conf/AllowUserFXP

echo 'no' > /etc/pure-ftpd/conf/AllowAnonymousFXP

echo 'no' > /etc/pure-ftpd/conf/AutoRename

echo 'yes' > /etc/pure-ftpd/conf/AnonymousCantUpload

echo 'yes' > /etc/pure-ftpd/conf/NoChmod

echo '80' > /etc/pure-ftpd/conf/MaxDiskUsage

echo 'yes' > /etc/pure-ftpd/conf/CustomerProof

echo '2' > /etc/pure-ftpd/conf/TLS

echo "yes" > /etc/pure-ftpd/conf/IPV4Only

systemctl restart pure-ftpd