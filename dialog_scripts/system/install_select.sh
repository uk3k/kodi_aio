#!/bin/bash
#select system type

#print setup mode selection
input=`whiptail --backtitle "$headline" \
        --title "System Type selection" \
        --menu "\nDo you want to use your System as Host or as Client? \n\n " 20 100 2 \
                "Host"        ""	\
                "Client"      ""	3>&1 1>&2 2>&3`
sys_type=$input

#call scripts for host or client
if [ "$sys_type" = "Host" ] 
	then

	else

fi
