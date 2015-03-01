#!/bin/bash
###tweaks for mysql

#add user kodi to mysql and grant privileges
mysql -u root --password=$mysql_passwd -e "CREATE USER 'kodi'@'%' IDENTIFIED BY 'kodi'"
mysql -u root --password=$mysql_passwd -e "GRANT ALL ON *.* TO 'kodi'@'%'"

#update my.cnf to allow connections from the local net
replace="s/bind-address*.*/bind-address = $mysql_host/" 
sed -i -e "$replace" /etc/mysql/my.cnf
