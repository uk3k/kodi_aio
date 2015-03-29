#!/bin/bash
#set mysql-server ip
whiptail --backtitle "$headline" \
        --title "MySQL-Server IP-Address" \
        --msgbox "\nThe IP-Address of the MySQL-Server will be set to the host's IP: $nw_ip \n\nPress Enter to continue" 12 100
sql_ip="$nw_ip"
