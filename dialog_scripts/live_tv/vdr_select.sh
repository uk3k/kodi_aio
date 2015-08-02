#!/bin/bash
#enable live-tv support

if [ "$tv_card_present" = "true" ]
            then        
                        if (whiptail --backtitle "$headline" \
                                    --title "Install VDR" \
                                    --yesno "\nDo you want to install Live-TV support? \n\n " 15 100)
                                    then
                                                tv_vdr="true"
                                                tv_prompt_scan="true"
                                    else
                                                tv_vdr="false"
                                                tv_prompt_scan="false"
                        fi
            else
                        if (whiptail --backtitle "$headline" \
                                    --title "Install VDR" \
                                    --yesno "\nNo working TV-Card was detected. \n\nDo you want to install Live-TV support anyway? \n\n " 15 100)
                                    then
                                                tv_vdr="true"
                                                tv_prompt_scan="true"
                                    else
                                                tv_vdr="false"
                                                tv_prompt_scan="false"
                        fi

