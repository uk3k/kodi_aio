#!/bin/bash
#define default settings

#version
script_version="1.0 Alpha"

#setup mode
setup="default"             #default, custom

#system
sys_type="host"             #host, client
. /gfx_detection            #run gfx_detection.sh to determine the actual graphics vendor of the system
$sys_fgx                    #amd, nvidia, intel, other

#media auto mount
media_mount="false"         #false, true

#networking
#assume networking is working as we were using netinstall
. /network_detection.sh     #run network_detection.sh to get *value* for each variable
$nw_iface                   #detected primary network interface; if $nw_iface="eth*" AND $wifi_present="true"--> prompt; else keep interface
$nw_wifi_present            #detected wifi state; if $nw_wifi_present="true" and $nw_iface!="wlan*" --> prompt, else false
$nw_use_wifi                #false, true; see $nw_wifi_present                
$nw_wifi_ssid               #detected wifi ssid; if $nw_use_wifi=true --> prompt; else unset
$nw_wifi_psk                #detected wifi psk; if $nw_use_wifi=true --> prompt; else unset
$nw_ip                      #detected ip-address
$nw_netmask                 #detected netmask
$nw_gateway                 #detected gateway
$nw_dns1                    #detected nameserver #1          
$nw_dns2                    #detected nameserver #2

#mysql
sql_rootpw="Secure0n3"      #not really secure root password for the mysql server
sql_userpw="kodi"           #pretty unsecure password for the sql-user

#live-tv
tv_vdr="true"               #false, true
tv_dvb_type="dvbc"          #dvbc, dvbt, dvbs
tv_oscam="true"             #false, true
tv_prefcg_oscam="true"      #false, true
tv_provider="kbw"           #kbw(KabelBW), um(unity-media), kd(kabel deutschland), hdplus(hd+), will add more in the future 
tv_cardreader="smargo"      #smargo, smartreader
tv_cr_busid="000:000"       #***.***; bus:id of the present usb-cardreader; run card-reader_detection.sh to find cardreaders in custom setup, else show a prompt of all usb-devices
tv_prompt_scan="false"      #false, true; is set in custom setup by dvb-card_detection.sh to true if any useable tv-cards were found
tv_scan="false"             #false, true; always false if dvb-card_detection.sh fails in custom setup to find useable tv_cards

#pyload
dl_pyload="false"           #false, true; install pyload download manager
