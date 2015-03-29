#!/bin/bash
#network settings

input=`whiptail --backtitle "$headline" \
        --title "Network Settings" \
        --radiolist "\nSelect if you want to use static or DHCP TCP/IP settings. \n\nNote: It's highly recommended to use static TCP/IP settings for the host! \n\n " 15 100 2 \
                "Static"        ""      on      \
                "DHCP"          ""      off     3>&1 1>&2 2>&3`
nw_mode=$input
