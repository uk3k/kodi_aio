#!/bin/bash
#V1.0.0.0.A

#print welcome message
whiptail --backtitle "$headline" \
        --title "Disclaimer" \
        --msgbox "\nWelcome to the uk3k.de Kodi All in One installer script. \nPlease report bugs to github@uk3k.de \n\nPress Enter to continue" 12 100

#print setup mode selection
input=`whiptail --backtitle "$headline" \
        --title "System Type selection" \
        --menu "\nDo you want to use your System as Host or as Client? \n\n " 20 100 2 \
                "Host"        ""	\
                "Client"      ""	3>&1 1>&2 2>&3`
sys_type=$input

if [ "$sys_type" = "Host" ]
	then
	#execute defaults script to get missing variables
		. $dialog/defaults.sh > /dev/null

	#print setup mode selection
		input=`whiptail --backtitle "$headline" \
        		--title "Setup mode - Host install" \
        		--menu "\nDo you want use the default setup settings or customize them? \n\nMost important default settings are: $sys_type \n
        	Graphics Vendor:                $sys_gfx
		Network Interface:              $nw_iface
		IP-Address Settings:            $nw_mode
		IP-Address:                     $nw_ip
		Live-TV Support:                $tv_vdr
		DVB-* Type:                     $tv_dvb_type
		Install PayTV-Support:          $tv_oscam
		Smart-Card-Reader:              $tv_cardreader
		Pyload Download Manager:        $add_pyload \n\n " 30 100 2 \
                "Default"        ""	\
                "Customize"      ""	3>&1 1>&2 2>&3`
		setup=$input
		
		#execute default or cutom setup routine
			if [ "$setup" = "Customize" ] 
				then
					. $dialog/customize.sh
				else
					. $dialog/summary.sh
			fi
	else
		#execute defaults script to get missing variables
		. $dialog/defaults_client.sh > /dev/null

	#print setup mode selection
		input=`whiptail --backtitle "$headline" \
        		--title "Setup mode - Client install" \
        		--menu "\nDo you want use the default setup settings or customize them? \n\nMost important default settings are: $sys_type \n
        	Graphics Vendor:                $sys_gfx
		Network Interface:              $nw_iface
		IP-Address Settings:            $nw_mode
		IP-Address:                     $nw_ip \n\n " 20 100 2 \
                "Default"        ""	\
                "Customize"      ""	3>&1 1>&2 2>&3`
		setup=$input
		
		#execute default or cutom setup routine
			if [ "$setup" = "Customize" ] 
				then
					. $dialog/customize_client.sh
				else
					. $dialog/summary_client.sh
			fi
fi


