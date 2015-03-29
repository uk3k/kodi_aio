#!/bin/bash

#print welcome message
whiptail --backtitle "$headline" \
        --title "Disclaimer" \
        --msgbox "\nWelcome to the uk3k.de Kodi All in One installer script. \n\nPress Enter to continue" 12 100


#execute defaults script to get missing variables
. $dialog/defaults.sh

#print setup mode selection
input=`whiptail --backtitle "$headline" \
        --title "Setup mode" \
        --menu "\nDo you want use the default setup settings or customize them? \n\nMost important default settings are: \n
        Graphics Vendor:		$sys_gfx
        Network Interface:		$nw_iface
	IP-Address Settings:		$nw_mode
        IP-Address:			$nw_ip
	Live-TV Support:		$tv_vdr
	DVB-* Type:			dvb-$tv_dvb_type
	Install OSCAM SoftCam:		$tv_oscam
	Smart-Card-Reader:		$tv_cardreader
	Pyload Download Manager:	$add_pyload \n\n " 30 100 2 \
                "Default"        ""	\
                "Customize"      ""	3>&1 1>&2 2>&3`
setup=$input

#execute default or cutom setup routine
if [ "$setup" = "Customize" ] 
	then
		. $dialog/customize_settings.sh
	else
		. $dialog/summary.sh
fi
