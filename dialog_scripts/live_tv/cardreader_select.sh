#!/bin/bash
#select card-reader for oscam

input=`whiptail --backtitle "$headline" \
        --title "Smart-Card-Reader" \
        --menu "\nSelect your Card-Reader for OSCAM \n\n " 30 100 2 \
                "smargo"           ""	\
                "smartreader"      ""	3>&1 1>&2 2>&3`
tv_cardreader=$input
