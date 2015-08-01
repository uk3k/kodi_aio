#!/bin/bash
#select card-reader for oscam
if [ "$tv_vdr" = "true" ] && [ "$tv_oscam" = "true" ]
        then
        input=`whiptail --backtitle "$headline" \
                --title "Smart-Card-Reader" \
                --menu "\nSelect your Card-Reader for OSCAM "$tv_cr_busid" \n\n " 30 100 2 \
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
                        fi
                        while [ "$inputok" = "false" ]; do
                                IFS=$'\n'
                                array=( $(lsusb |awk '!/^ / && NF {print $1,$2,$3,$4,$6,$7,$8,$9,$10}') )
                                unset IFS
                                        RADIOLIST=()
                                        for ((i=0; i<${#array[@]}; i++))
                                                do
                                                        RADIOLIST+=("$i" "${array[$i]}" "OFF")
                                                done
                                        let ARLENGTH=${#array[@]}
                                        input=`whiptail --backtitle "$headline" \
                                                        --title "Select your Card-Reader" \
                                                        --radiolist "Available USB-devices:" 25 100 \
                                                        $ARLENGTH "${RADIOLIST[@]}" 3>&1 1>&2 2>&3`
                                        tv_cr_busid=$(echo ${array[$input]} | awk -v OFS=':' '{print $2,$4}' | sed s/://2)
                                if [ -z "$input" ]
                                        then
                                                tv_cr_busid="000:000"
                                                inputok="true"
                                        else
                                                inputok="true"
                                fi
                        done
        fi        
        else
                tv_cardreader="None"       
fi        
