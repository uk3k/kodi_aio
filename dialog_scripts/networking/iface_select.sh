#!/bin/bash
#Select or enter primary network interface controller

if (whiptail --backtitle "$headline" \
        --title "Primary network interface" \
        --yesno "\nSetup detected $nw_iface as active network interface. \nThis interface is configured with IP $nw_ip \n\nIs that correct? \n\n " 15 100)
        then
                inputok="true"
        else
                inputok="false"
                while [ "$inputok" = "false" ]; do
                        read -ra array <<<$(ifconfig -a | awk '!/^ / && NF {print $1; print $1}')
                        input=`whiptail --backtitle "$headline" \
                        --notags \
                        --title "Primary network interface" \
                        --menu "\nSelect your primary network interface \n " 16 100 4 "${array[@]}" 3>&1 1>&2 2>&3`
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
fi
