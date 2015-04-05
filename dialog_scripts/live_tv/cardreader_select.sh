#!/bin/bash
#select card-reader for oscam
if [ "$tv_vdr" = "true" ] && [ "$tv_oscam" = "true" ]
        then
        input=`whiptail --backtitle "$headline" \
                --title "Smart-Card-Reader" \
                --menu "\nSelect your Card-Reader for OSCAM \n\n " 30 100 2 \
                        "Smargo"           ""	\
                        "Smartreader"      ""	3>&1 1>&2 2>&3`
        tv_cardreader=$input

        if [ "$tv_cr_busid" = "000:000" ]
                then
                        if (whiptail --backtitle "$headline" \
                        --title "Card-Reader not found" \
                        --yesno "\nSetup couldn't find your Card-Reader automatically. \nDo you want to select it manually? \n\n " 15 100)
                then
                        inputok="false"
                else
                        inputok="true"
                        while [ "$inputok" = "false" ]; do
                                read -ra array <<<$(lsusb)
                                input=`whiptail --backtitle "$headline" \
                                --notags \
                                --title "Available USB-Devices" \
                                --menu "\nSelect your Card-Reader \n " 16 100 4 "${array[@]}" 3>&1 1>&2 2>&3`
                                nw_iface=$input
                                if [ -z "$input" ]
                                        then
                                                whiptail --backtitle "$headline" \
                                                --title "Wrong input" \
                                                --msgbox "\nNothing selected :-(. \n\nPlease try again" 15 100
                                                inputok="false"
                                        else
                                                inputok="true"
                                fi
                        done
        else
                tv_cardreader="None"       
        fi
fi        
