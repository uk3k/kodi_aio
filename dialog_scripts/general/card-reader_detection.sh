#!/bin/bash
#determine the selected smart-card-reader's usb-port
#works actually only for smargo

if [ $tv_cardreader = "smargo" ] 
  then
    tv_cr_busid=$(lsusb | grep ^Future.* | awk '{print $1}') 
  esle
    tv_cr_busid="000:000"
fi

