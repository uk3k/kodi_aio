#!/bin/bash
###tweaks for mysql

#add user kodi to mysql and grant privileges
mysql -u root --password=$sql_rootpw -e "CREATE USER 'kodi'@'%' IDENTIFIED BY '$sql_userpw'"
mysql -u root --password=$sql_rootpw -e "GRANT ALL ON *.* TO 'kodi'@'%'"

#update my.cnf to allow connections from the local net
replace="s/bind-address*.*/bind-address = $sql_ip/" 
sed -i -e "$replace" /etc/mysql/my.cnf
