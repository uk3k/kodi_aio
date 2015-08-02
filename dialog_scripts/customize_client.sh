#!/bin/bash
#customize default settings for clients
#V1.0.0.0.A

#define functions for customizations
#system
function customize-system {
 . $dialog/system/graphics_select.sh        	#system settings: graphics vendor
 . $dialog/system/automount.sh        		    #system settings: check for media files
}

#networking
function customize-networking {
. $dialog/networking/iface_select.sh        	#network settings: primary networking interface
. $dialog/networking/network_settings.sh    	#network settings: DHCP/Static
. $dialog/networking/ip_settings.sh         	#network settings: ip address
. $dialog/networking/netmask_settings.sh    	#network settings: netmask
. $dialog/networking/gateway_settings.sh    	#network settings: gateway
. $dialog/networking/dns1_settings.sh       	#network settings: Nameserver #1
. $dialog/networking/dns2_settings.sh       	#network settings: Nameserver #2
. $dialog/networking/wifi_settings.sh       	#network settings: wifi
}

#mysql
function customize-mysql {
 . $dialog/mysql/server_ip.sh			  #mysql settings: mysql-server ip address	
 . $dialog/mysql/user_password.sh		#mysql settings: user password for kodi-database
}

##additional stuff
#function customize-additional {
#nothing here yet		#additional stuff settings
#}

#print selection menu
whiptail --backtitle "$headline" \
        --title "Select Settings to customize" \
        --checklist --separate-output "\nSelect the settings you want to customize \n\n " 30 100 5 \
                "System"		""	on     \
                "Networking"            ""	on     2>selections
while read input
do
	case $input in
		System) 	customize-system	;;
		Networking) 	customize-networking	;;        
    Other) 		customize-additional	;;
		*)					;;
	esac
done < selections

#print summary
. $dialog/summary_client.sh
