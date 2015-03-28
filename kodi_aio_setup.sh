#!/bin/bash
#Version v1.0.0.0 Alpha


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
