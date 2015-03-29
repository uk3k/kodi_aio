#!/bin/bash
#wifi-configuration

if [ "$nw_iface" = "^wlan.*" ]
	then
	#ask for wifi configuration
	if (whiptail --backtitle "$headline" --title "Configure Wifi" \
		--yesno "\nWifi was selected as primary network interface but is not configured yet. \nDo you want to do this now? \n " 15 100) 
		then
		        #SSID for wifi-configuration
		        unset valid
		        while [ -z "$valid" ]; do
        		input=`whiptail --backtitle "$headline" \
                		--title "WiFi-configuration - SSID" \
                		--inputbox "\nConfirm or enter the SSID (network name) \nfor your wifi-configuration \n\n " 15 100 "YourNetworkName" 3>&1 1>&2 2>&3`
        		nw_wifi_ssid=$input
        		if [ -z "$input" ]
                                then
                                        whiptail --backtitle "$headline" \
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
        		input=`whiptail --backtitle "$headline" \
                		--title "WiFi-configuration - PSK" \
                		--inputbox "\nConfirm or enter the PSK (pre-shared-key) for your wifi-configuration \n\n " 15 100 "YourNetworkPass" 3>&1 1>&2 2>&3`
        		nw_wifi_psk=$input
        		if [ -z "$input" ]
                                then
                                        whiptail --backtitle "$headline" \
                                        --title "Wrong input" \
                                        --msgbox "\nYou didn't enter anything! :-(. \n\nPlease try again" 15 100
                                        unset valid
                                else
                                        valid="ok"
                        fi
	                done
        		
        		#determine wifi nic
        		nw_iface=$(ifconfig -a | grep ^wlan.* | awk '{print $1}')
        fi
fi
