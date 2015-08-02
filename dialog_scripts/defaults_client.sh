#!/bin/bash
#define default settings for client
#V1.0.0.0.A

#Headline
headline="uk3k.de V$script_version Kodi All in One installer script"

#setup mode
setup="Default"             #Default, Customize

#system
sys_type="Client"             #Host, Client
. $hw/gfx_detection.sh      #run gfx_detection.sh to determine the actual graphics vendor of the system
sys_fgx="$sys_fgx"          #amd, nvidia, intel, other
. $hw/os_detection.sh       #run os_detection.sh to determine the actual operating system
sys_os="$sys_os"            #the actual operating system

#media auto mount
media_mount="false"         #false, true

#networking
#assume networking is working as we were using netinstall
. $hw/network_detection.sh          #run network_detection.sh to get *value* for each variable
nw_iface="$nw_iface"                #detected primary network interface; if $nw_iface="eth*" AND $wifi_present="true"--> prompt; else keep interface
nw_mode="DHCP"                      #DHCP, Static; detected ip address configuration
nw_wifi_present="$nw_wifi_present"  #detected wifi state; if $nw_wifi_present="true" and $nw_iface!="wlan*" --> prompt, else false
nw_use_wifi="$nw_use_wifi"          #false, true; see $nw_wifi_present                
nw_wifi_ssid="$nw_wifi_ssid"        #detected wifi ssid; if $nw_use_wifi=true --> prompt; else unset
nw_wifi_psk="$nw_wifi_psk"          #detected wifi psk; if $nw_use_wifi=true --> prompt; else unset
nw_ip="$nw_ip"                      #detected ip-address
nw_netmask="$nw_netmask"            #detected netmask
nw_gateway="$nw_gateway"            #detected gateway
nw_dns1="$nw_dns1"                  #detected nameserver #1          
nw_dns2="$nw_dns2"                  #detected nameserver #2

#mysql
sql_install="false"                 #true, false; install the Mysql-Server
sql_ip="you didn't enter anything!" #ip address of the lokal mysql-server
sql_rootpw=""                       #not really secure root password for the mysql server
sql_userpw="kodi"                   #pretty unsecure password for the sql-user

#live-tv
tv_vdr="false"                      #don't install vdr for clients!
tv_dvb_type="None"                  #C, T, S. None (dvb-*)
tv_oscam="false"                    #false, true
tv_prefcg_oscam="false"             #false, true
tv_provider=""                      #KBW(KabelBW), UM(unity-media), KD(kabel deutsc hland), HDPlus(hd+), SKY(Deutschland), None will add more in the future 
tv_cardreader="None"                #Smargo, Smartreader, None
tv_prompt_scan="false"              #false, true; is set in custom setup by dvb-card_detection.sh to true if any useable tv-cards were found
tv_scan="false"                     #false, true; always false if dvb-card_detection.sh fails in custom setup to find useable tv_cards

#pyload
add_pyload="false"           #false, true; install pyload download manager
