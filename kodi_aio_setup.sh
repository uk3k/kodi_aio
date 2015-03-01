#!/bin/bash
#Version v0.8.0.0 Alpha

#Changes in 0.8.0.0
#-all scripts are now hosted at github for much simpler updating
#-optimized script structure
#-bugfixes in several sub-scripts
#-vdr and its addons are now build from source as there where several issues with dvbapi and streamdev
#-first pass of an graphical setup menu using whiptail

#Changes in 0.7.0.1
#-fixed bug in networked detection
#-improved wifi nic detection

###Written by Paul Krause(uk3k)
###special thanks to Krautmaster and aseith.com for inspiration and all those users on the internet that allready have asked and answered the 
###questions i had while writing this script

#####################################################################################
########	define default settings						####
#####################################################################################
#the default package selection:
#if host: install xbmc, mysql, vdr, oscam, use dhcp ip as static one and bind all local servers to it
#if client: ask for mysql-server ip of database
#ask only for things that couln't be determined automatically
live_tv="true"			#live tv support by latest vdr (true/false)
oscam="true"			#oscam softcam for pay tv decryption
w_scan="false"			#automatically scan for tv channels and add them to channels.conf for vdr (true/false)
change_mysql_addr="false"	#don't use system's ip address as mysql-server-address (true/false)  
mysql_passwd="secure"		#root password for mysql server; for database access will be user:password "xbmc":"xbmc" hardcoded
static_ip="true"		#use static ip address settings; this is absolutely recommended for mysql and vdr
pyload="false"			#install pyload download manager (true;false)
client_standalone="false"	#install client as client for existing xbmc database host


#####################################################################################
########	define script properties						####
#####################################################################################

#define script properties

##ubuntu version
os=$(lsb_release -c | awk '{ print $2 }')
if [ "$os" != "trusty" ]
	then
		echo "This script only supports Ubuntu 14.04 LTS Trusty Thar"
		exit 
fi

##script version
version=v0800

##working dir
install="/tmp/kodi_aio/"

#download url
url="https://github.com/uk3k/kodi_aio.git"

#path to install scripts
scripts="$install/install_scripts/"

#path to install scripts
scripts="$install/config_scripts/"

#path to user dialog scripts
userinput="$install/dialog_scripts"

#####################################################################################


#####################################################################################
########	Prepare system for installation and download scripts		####
#####################################################################################


#####################################################################################


#####################################################################################
########	some stuff for improved look of the dialog				####
#####################################################################################
#infotext farbe: \e[0;32m 
#beispieltextfarbe: \e[0;33m
#fehleinagbe farbe: \e[1;31m 
#farbcode aufheben: \e[0m 
##
spacer="	"
border="	----------------------------------------------------------------------------------"
#####################################################################################


#####################################################################################
########	setup dialog - do not modify below!!!				####
#####################################################################################
#print welcome message
. $scripts/print_welcome.txt

#prepare setup
. $scripts/read_system_specs.txt

#####################################################################################
########	general settings for both client or host				####
#####################################################################################

#userinput primary network interface if none was found
. $userinput/sel_sys_primary_nic.txt

#userinput use wifi?
. $userinput/sel_sys_wifi.txt

#userinput gfx selection
. $userinput/sel_sys_gfx.txt

#userinput host/client selection
. $userinput/sel_sys_system_type.txt

#userinput select automatic or custom install
. $userinput/sel_sys_install_mode.txt

#####################################################################################


#####################################################################################
########	default setting mysql host for default host installation	####
#####################################################################################

if [ "$install_mode" = "default" ] && [ "$target" = "host" ]
	then

########	#mysql server settings (sel_host_sql*)		#################
		
		#mysql server ip settings
		. $userinput/sel_host_sql_mysql_ip.txt

fi
#####################################################################################


#####################################################################################
########	default setting mysql host for default client installation	####
#####################################################################################

if [ "$install_mode" = "default" ] && [ "$target" = "client" ]
	then
########	#userinput mysql host ip (sel_client_sql*)	#################
		. $userinput/sel_client_sql_mysql_ip.txt

fi
#####################################################################################


#####################################################################################

#####################################################################################
########	custom settings if custom installation as host was selected	####
#####################################################################################
 
if [ "$install_mode" = "custom" ] && [ "$target" = "host" ]
	then

########	#userinput live tv settings (sel_host_tv*)		#################
		
		#install live tv support?
		. $userinput/sel_host_tv_live_tv.txt

		#install oscam?
		. $userinput/sel_host_tv_oscam.txt		
					
		#select card reader for oscam?
		. $userinput/sel_host_tv_card_reader.txt

		#scan for tv channels?		
		. $userinput/sel_host_tv_scan_tv_channels.txt
						

########	#userinput network settings (sel_host_ip*)		#################

		#use static ip?
		. $userinput/sel_host_ip_static_networking.txt
		
		#static ip settings?
		. $userinput/sel_host_ip_static_address.txt			
		
		
########	#mysql server settings (sel_host_sql*)		#################
		
		#mysql server ip settings
		. $userinput/sel_host_sql_mysql_ip.txt	
	
		#mysql server password settings
		. $userinput/sel_host_sql_mysql_password.txt


########	#pyload download manager (sel_hosT_pyl*)		##################
	
		
		#install pyload download manager?
		. $userinput/sel_host_pyl_pyload.txt
		
fi
#####################################################################################


#####################################################################################
########	custom settings if custom installation as client was selected	####
#####################################################################################

if [ "$install_mode" = "custom" ] && [ "$target" = "client" ]
	then
	
########	#userinput client type (sel_client_sys_*)		###################
	
		#install client as stand alone mediacanter?
		. $userinput/sel_client_sys_standalone.txt

		
########	#userinput mysql settings client (sel_client_sql*)	###################

		#mysql settings for non-stand-alone client
		. $userinput/sel_client_sql_mysql_ip.txt


fi
#####################################################################################



#####################################################################################
########	user input summary							####
#####################################################################################

#print summary
. $scripts/print_summary.txt


#####################################################################################
#####################################################################################
#####################################################################################
#####################################################################################
#####################################################################################



#####################################################################################
########	install base packets							####
#####################################################################################

#install base packets
. $instscpt/install_base_packets.txt


#####################################################################################


#####################################################################################
########	apply system tweaks							####
#####################################################################################

#user tweaks
. $cfgscpt/cfg_system_tweaks.txt


#####################################################################################


#####################################################################################
########	install graphics driver						####
#####################################################################################

#graphics driver for intel, amd, nvidia
. $instscpt/install_gfx_driver.txt


#####################################################################################


#####################################################################################
########	install kodi and neccesary tweaks					####
#####################################################################################

#install kodi
. $instscpt/install_kodi_helix.txt

#apply tweaks
. $cfgscpt/cfg_kodi.txt


#####################################################################################


#####################################################################################
########	install mysql for stand alone client					####
#####################################################################################

#install mysql server
. $instscpt/install_client_standalone_mysql.txt

#apply mysql tweaks
. $cfgscpt/cfg_mysql.txt


#####################################################################################


#####################################################################################
########	install packets for live tv						####
#####################################################################################

#install vdr and dvbapi
. $instscpt/install_vdr.txt

#apply tweaks for vdr
. $cfgscpt/cfg_vdr.txt

#install channels.conf
. $instscpt/install_channels.conf.txt

#install oscam
. $instscpt/install_oscam.txt

#apply tweaks for oscam
. $cfgscpt/cfg_oscam.txt


#####################################################################################



#####################################################################################
########	install mysql for host						####
#####################################################################################

#install mysql server
. $instscpt/install_host_mysql.txt

#apply mysql tweaks
. $cfgscpt/cfg_mysql.txt


#####################################################################################


#####################################################################################
########	install samba for host						####
#####################################################################################

#install samba
. $instscpt/install_samba.txt

#apply samba tweaks
. $cfgscpt/cfg_samba.txt


#####################################################################################


#####################################################################################
########	networking								####
#####################################################################################

#apply network tweaks
. $cfgscpt/cfg_network.txt

#apply wifi tweaks
. $cfgscpt/cfg_wifi.txt


#####################################################################################


#####################################################################################
########	pyload									####
#####################################################################################

#install pyload
. $instscpt/install_pyload.txt


#####################################################################################


#####################################################################################
########	alsa settings								####
#####################################################################################

#apply alsa tweaks
. $cfgscpt/cfg_alsa.txt


#####################################################################################

#####################################################################################
########	clean up								####
#####################################################################################

#run clean up script
. $instscpt/install_clean_up.txt


#####################################################################################


#####################################################################################
########	finished! >> reboot							####
#####################################################################################
reboot
