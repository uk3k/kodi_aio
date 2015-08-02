#!/bin/bash
#set mysql-server ip
if [ "$sys_type" = "Host" ]
        then
                whiptail --backtitle "$headline" \
                        --title "MySQL-Server IP-Address" \
                        --msgbox "\nThe IP-Address of the MySQL-Server will be set to the host's IP: $nw_ip \n\nPress Enter to continue" 12 100
                sql_ip="$nw_ip"
        else
                unset valid
                while [ -z "$sql_ip" ] || [ -z "$valid_range" ] || [ -z "$valid" ] || [ "$valid_syntax" != "true" ];do
                        input=`whiptail --backtitle "$headline" \
                        --title "MySQL-Server IP-address" \
                        --inputbox "\nPlease Enter your MySQL-Server's IP-Address \n\n " 15 100 3>&1 1>&2 2>&3`
                        sql_ip=$input
                        if [ -n "$sql_ip" ]
                                then
                                        valid_range="$(echo $sql_ip | awk -F'.' '$1 >=1 && $1 <=255 && $2 >=0 && $2 <=255 && $3 >=0 && $3 <=255 && $4 >=0 && $4 <=255 && $5 <0')"
                                        valid_syntax="$(echo $sql_ip | rev | cut -c 1 )"
                                        case "$valid_syntax" in
                                                [0-9] ) valid_syntax=true;;
                                                * )     valid_syntax=false;;
                                        esac
                                                if [ -z "$valid_range" ] || [ "$valid_syntax" != "true" ]
                                                        then
                                                                whiptail --backtitle "$headline" \
                                                                --title "Wrong input" \
                                                                --msgbox "\n
                                                                IP-range or syntax incorrect. \nCorrect syntax is something like xxx.xxx.xxx.xxx \n\nPlease try again" 15 100
                                                                unset sql_ip
                                                        else
                                                                valid="ok"
                                                fi
                                else
                                        whiptail --backtitle "$headline" \
                                        --title "Wrong input" \
                                        --msgbox "\n
                                        You didn't enter anything :-( \n\nPlease try again" 15 100
                                        unset sql_ip
                        fi
        done
fi
