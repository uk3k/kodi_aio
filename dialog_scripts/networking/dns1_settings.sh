#!/bin/bash
#DNS1 for TCP/IP configuration
#V1.0.0.0.A

unset valid
while [ -z "$nw_dns1" ] || [ -z "$valid_range" ] || [ -z "$valid" ] || [ "$valid_syntax" != "true" ];do
        input=`whiptail --backtitle "$headline" \
        --title "TCP/IP configuration - Nameserver #1" \
        --inputbox "\nConfirm or enter the DNS #1 for the host's TCP/IP configuration \n\n " 15 100 "$nw_gateway" 3>&1 1>&2 2>&3`
        nw_dns1=$input
        if [ -n "$nw_dns1" ]
        then
        valid_range="$(echo $nw_dns1 | awk -F'.' '$1 >=1 && $1 <=255 && $2 >=0 && $2 <=255 && $3 >=0 && $3 <=255 && $4 >=0 && $4 <=255 && $5 <0')"
    	valid_syntax="$(echo $nw_dns1 | rev | cut -c 1 )"
		case "$valid_syntax" in
        		[0-9] ) valid_syntax=true;;
        		* )     valid_syntax=false;;
		esac
    		if [ -z "$valid_range" ] || [ "$valid_syntax" != "true" ]
    		then
                whiptail --backtitle "$headline" \
                --title "Wrong input" \
                --msgbox "\nRange or syntax incorrect. \nCorrect syntax is something like xxx.xxx.xxx.xxx \n\nPlease try again" 15 100
                unset nw_dns1
                else
                valid="ok"
                fi
        else
        whiptail --backtitle "$headline" \
                --title "Wrong input" \
                --msgbox "\n
                You didn't enter anything :-( \n\nPlease try again" 15 100
                unset nw_dns1
        fi
done
