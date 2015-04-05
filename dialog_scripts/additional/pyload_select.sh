#!/bin/bash
#select poyload to install

input=`whiptail --backtitle "$headline" \
            --title "Install Pyload" \
            --yesno "\nDo you want to install the Pyload Download Manager? \n\n " 15 100\`
    if [ "$input" = "0" ]
      then
        add_pyload="true"
      else
        add_pyload="false"
    fi
