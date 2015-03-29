#!/bin/bash
#set mysql user password

unset valid
  while [ -z "$valid" ]; do
    input=`whiptail --backtitle "$headline" \
    --title "MySQL User-Password" \
    --passwordbox "\nEnter the new user password for the MySQL-Server  \n\n " 15 100 3>&1 1>&2 2>&3`
    sql_userpw=$input
      if [ -z "$input" ]
        then
          whiptail --backtitle "$headline" \
          --title "Wrong input" \
          --msgbox "\nYou didn't enter anything! :-(. \n\nPlease try again" 15 100
          unset valid
        else
          input=`whiptail --backtitle "$headline" \
          --title "Confirm MySQL User-Password" \
          --passwordbox "\nRe-Enter the new user password for the MySQL-Server  \n\n " 15 100 3>&1 1>&2 2>&3`
          sql_userpw2=$input
            if [ "$sql_userpw" = "$sql_userpw2" ]
              then
                valid="ok"
              else
                whiptail --backtitle "$headline" \
                --title "Wrong input" \
                --msgbox "\nThe passwords you've entered did not match! \n\nPlease try again" 15 100
          unset valid
      fi
  done
