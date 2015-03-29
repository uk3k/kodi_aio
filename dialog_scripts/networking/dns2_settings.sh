#!/bin/bash
#DNS2 for TCP/IP configuration
#V1.0.0.0.A

unset valid
while [ -z "$nw_dns2" ] || [ -z "$valid_range" ] || [ -z "$valid" ] || [ "$valid_syntax" != "true" ];do
        input=`whiptail --backtitle "$headline" \
        --title "TCP/IP configuration - Nameserver #2" \
        --inputbox "\nConfirm or enter the DNS #2 for the host's TCP/IP configuration \n\n " 15 100 "8.8.8.8" 3>&1 1>&2 2>&3`
        nw_dns2=$input
        if [ -n "nw_$dns2" ]
        then
        valid_range="$(echo $nw_dns2 | awk -F'.' '$1 >=1 && $1 <=255 && $2 >=0 && $2 <=255 && $3 >=0 && $3 <=255 && $4 >=0 && $4 <=255 && $5 <0')"
    	valid_syntax="$(echo $nw_dns2 | rev | cut -c 1 )"
		case "$valid_syntax" in
        		[0-9] ) 	valid_syntax=true;;
        		* ) 		valid_syntax=false;;
		esac
    		if [ -z "$valid_range" ] || [ "$valid_syntax" != "true" ]
    		then
                whiptail --backtitle "$headline" \
                --title "Wrong input" \
                --msgbox "\n
                Range or syntax incorrect. \nCorrect syntax is something like xxx.xxx.xxx.xxx \n\nPlease try again" 15 100
                unset nw_dns2
                else
                valid="ok"
                fi
        else
        whiptail --backtitle "$headline" \
                --title "Wrong input" \
                --msgbox "\nYou didn't enter anything :-( \n\nPlease try again" 15 100
                unset nw_dns2
        fi
done
