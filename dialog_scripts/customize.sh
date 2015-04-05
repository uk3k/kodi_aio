#!/bin/bash
#customize default settings
#V1.0.0.0.A

#define functions for customizations
#system
function customize-system {
 . $dialog/system/graphics_select.sh        	#system settings: graphics vendor
 . $dialog/system/automount.sh        		#system settings: check for media files
}

#mysql
function customize-mysql {
 . $dialog/mysql/server_ip.sh			#mysql settings: mysql-server ip address	
 . $dialog/mysql/root_password.sh        	#mysql settings: root password for mysql
 . $dialog/mysql/user_password.sh		#mysql settings: user password for kodi-database
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

#live-tv
function customize-livetv {
. $dialog/live_tv/vdr_select.sh			#live-tv settings: enable live-tv-support
. $dialog/live_tv/dvb-type_select.sh		#live-tv settings: select dvb-type
. $dialog/live_tv/scan_channels_select.sh	#live-tv settings: scan channels after setup
. $dialog/live_tv/oscam_select.sh		#live-tv settings: enable paytv descrambling support
. $dialog/live_tv/card-reader_select.sh		#live-tv settings: select cardreader for oscam
. $dialog/live_tv/precfg_oscam_select.sh	#live-tv settings: preconfigure paytv-provider for oscam
} 

#additional stuff
function customize-additional {
. $dialog/additional/pyload_select.sh		#additional stuff settings: install pyload download manager
}

function defaults {
 . $dialog/defaults.sh				#run the defaults-script again
}

#print selection menu
whiptail --backtitle "$headline" \
        --title "Select Settings to customize" \
        --checklist --separate-output "\nSelect the settings you want to customize \n\n " 30 100 5 \
                "System"		""	on     \
                "MySQL"			""	on     \
                "Networking"            ""	on      \
                "Live-TV"               ""	on      \
                "Additional Stuff"      ""	on      2>selections
while read input
do
	case $input in
		System) 	customize-system	;;
		MySQL) 		customize-mysql		;;
		Networking) 	customize-networking	;;        
                Live-TV) 	customize-livetv	;;
                Additional Stuff) customize-additional	;;
		*)		defaults		;;
	esac
done < selections

#print summary
. $dialog/summary.sh
