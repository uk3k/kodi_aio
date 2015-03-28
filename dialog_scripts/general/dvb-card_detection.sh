#!/bin/bash
#check if any dvb-card is already working

if [ -n "$(ls /dev/dvb/ | grep ^adapter.*)" ]
  then
    tv_prompt_scan="true"
  else
    tv_prompt_scan="false"
fi
          
