#!/bin/bash
#wifi-configuration

if [ "$nw_wifi_present" = "true" ] 
	then
	#ask for wifi configuration
	if (whiptail --backtitle "$headline" --title "Configure Wifi" \
		--yesno "\nWifi was detected but is not configured yet. \nDo you want to do this now? \n " 15 100) 
		then
		        #SSID for wifi-configuration
		        unset valid
		        while [ -z "$valid" ]; do
        		input=`whiptail --backtitle "uk3k.de V$version SndPi host initial setup" \
                		--title "WiFi-configuration - SSID" \
                		--inputbox "\nConfirm or enter the SSID (network name) \nfor your wifi-configuration \n\n " 15 100 "YourNetworkName" 3>&1 1>&2 2>&3`
        		ssid=$input
        		if [ -z "$input" ]
                                then
                                        whiptail --backtitle "uk3k.de V$version SndPi host initial setup" \
                                        --title "Wrong input" \
                                        --msgbox "\nYou didn't enter anything! :-(. \n\nPlease try again" 15 100
                                        unset valid
                                else
                                        valid="ok"
                        fi
                	done

        		#PSK for wifi-configuration
        		unset valid
        		while [ -z "$valid" ]; do
        		input=`whiptail --backtitle "uk3k.de V$version SndPi host initial setup" \
                		--title "WiFi-configuration - PSK" \
                		--inputbox "\nConfirm or enter the PSK (pre-shared-key) for your wifi-configuration \n\n " 15 100 "YourNetworkPass" 3>&1 1>&2 2>&3`
        		psk=$input
        		if [ -z "$input" ]
                                then
                                        whiptail --backtitle "uk3k.de V$version SndPi host initial setup" \
                                        --title "Wrong input" \
                                        --msgbox "\nYou didn't enter anything! :-(. \n\nPlease try again" 15 100
                                        unset valid
                                else
                                        valid="ok"
                        fi
	                done
        		
        		#determine wifi nic
        		wifi_nic=$(ifconfig -a | grep ^wlan.* | awk '{print $1}')
        fi
fi
