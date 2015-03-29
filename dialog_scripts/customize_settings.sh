#!/bin/bash
#customize default settings

#define functions for customizations
#system
function customize-system {
 . $dialog/system/graphics_select.sh        #system settings: graphics vendor
}

#networking
function customize-networking {
. $dialog/networking/iface_select.sh        #network settings: primary networking interface
. $dialog/networking/network_settings.sh    #network settings: DHCP/Static
. $dialog/networking/ip_settings.sh         #network settings: ip address
. $dialog/networking/netmask_settings.sh    #network settings: netmask
. $dialog/networking/gateway_settings.sh    #network settings: gateway
. $dialog/networking/dns1_settings.sh       #network settings: Nameserver #1
. $dialog/networking/dns2_settings.sh       #network settings: Nameserver #2
. $dialog/networking/wifi_settings.sh       #network settings: wifi
}

#live-tv
function customize-livetv {
 #do something
}

#dvb-type
function customize-dvbtype {
 #do something
}

#oscam
function customize-oscam {
 #do something
}

#card-reader
function customize-cardreader {
 #do something
}

#pyload
function customize-pyload {
 #do something
}

#print selection menu
input=`whiptail --backtitle "$headline" \
        --title "Select Settings to customize" \
        --checklist "\nSelect the settings you want to customize \n\n " 30 100 7 \
                "Graphics-Vendor"       ""      \
                "Networking"            ""      \
                "Live-TV"               ""      \
                "DVB-Type"              ""      \
                "PayTV-Support"         ""      \
                "Card-Reader"           ""      \
                "Pyload"                ""      3>&1 1>&2 2>&3`
selections=$input

#systemwhile read choice
while read selections
do
	case $selections in
		Graphics-Vendor) customize-system
		;;
		Networking) customize-networking
                ;;        
		*)
		;;
	esac
done

#networking
#. $dialog/networking/iface_select.sh        #network settings: primary networking interface
#. $dialog/networking/network_settings.sh    #network settings: DHCP/Static
#. $dialog/networking/ip_settings.sh         #network settings: ip address
#. $dialog/networking/netmask_settings.sh    #network settings: netmask
#. $dialog/networking/gateway_settings.sh    #network settings: gateway
#. $dialog/networking/dns1_settings.sh       #network settings: Nameserver #1
#. $dialog/networking/dns2_settings.sh       #network settings: Nameserver #2
#. $dialog/networking/wifi_settings.sh       #network settings: wifi


#print summary
. $dialog/summary.sh
