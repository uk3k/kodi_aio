#!/bin/bash
#enable live-tv support

if (whiptail --backtitle "$headline" \
            --title "Install Pyload" \
            --yesno "\nDo you want to install the Pyload Download Manager? \n\n " 15 100)
      then
        add_pyload="true"
      else
        add_pyload="false"
fi

