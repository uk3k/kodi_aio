#!/bin/bash
#customize default settings

#select settings to customize
input=`whiptail --backtitle "$headline" \
        --title "Select Settings to customize" \
        --menu "\nSelect the settings you want to customize \n\n " 30 100 2 \
                "Graphics Vendor"        ""	\
                "Live-TV"        ""	\
                "DVB-Type"        ""	\
                "PayTV Support"      "" \
                "Card-Reader"      "" \
                "Pyload"      ""	3>&1 1>&2 2>&3`
selections=$input

#system
. $dialog/system/graphics_select.sh        #system settings: graphics vendor

#networking
. $dialog/networking/iface_select.sh        #network settings: primary networking interface
. $dialog/networking/network_settings.sh    #network settings: DHCP/Static
. $dialog/networking/ip_settings.sh         #network settings: ip address
. $dialog/networking/netmask_settings.sh    #network settings: netmask
. $dialog/networking/gateway_settings.sh    #network settings: gateway
. $dialog/networking/dns1_settings.sh       #network settings: Nameserver #1
. $dialog/networking/dns2_settings.sh       #network settings: Nameserver #2
. $dialog/networking/wifi_settings.sh       #network settings: wifi


#print summary
. $dialog/summary.sh
