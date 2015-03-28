#!/bin/bash
###SndPi host initial setupscript
###needed packages
#git git-core

##preset script vars
version="1.0"
stpntwrk="network"
stpstrm="stream"

##ensure scripts are executable
chmod -R +x *.sh

##read network specs
. ./check_networking.sh

##preset default settings:
primary_iface=$primary_iface
ipsetting="Static"
ice_port="8000"
ice_login="icecastadmin"
ice_pass="secure"
stream_name="streampi"
stream_quality="0.6"
stream_bitrate="256"
stream_channels="2"
stream_public="No"
##############################

#print welcome message
whiptail --backtitle "uk3k.de V$version SndPi host initial setup" \
        --title "Disclaimer" \
        --msgbox "\nWelcome to the uk3k.de SndPi host initial setup script. \n\nPress Enter to continue" 12 100
###############################

##execute default setup if posible
if [ -n "$primary_iface" ] && [ -n "$ip_addr" ] 
	then #check if eth or wifi is ok
		if [ "$primary_iface" = "eth0" ] || [ "$wifi_configured" = "true" ]
			then
				. ./setup_default.sh
			else
				. ./setup_custom.sh
		fi
fi
