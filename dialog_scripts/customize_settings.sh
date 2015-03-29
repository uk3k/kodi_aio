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
. $dialog/live_tv/vdr_select.sh
}

#additional stuff
function customize-additional {
 #do something
}

#print selection menu
whiptail --backtitle "$headline" \
        --title "Select Settings to customize" \
        --checklist --separate-output "\nSelect the settings you want to customize \n\n " 30 100 4 \
                "System"		""	on     \
                "Networking"            ""	on      \
                "Live-TV"               ""	on      \
                "Additional Stuff"      ""	on      2>selections
while read input
do
	case $input in
		System) customize-system
		;;
		Networking) customize-networking
                ;;        
                Live-TV) customize-livetv
                ;;
                Additional Stuff) customize-additional
		*)
		;;
	esac
done < selections

#print summary
. $dialog/summary.sh
