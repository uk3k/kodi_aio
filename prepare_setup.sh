#!/bin/bash

#check if system ready for setup
clear
#exit if script was not executed by user root (sudo doesn't work!)
[[ `id -u` -eq 0 ]] || { echo "Must be root to run script"; exit 1; }

#exit if operationg system is not Ubuntu 14.04
if [ "$(lsb_release -c | awk '{ print $2 }')" != "trusty" ]
	then
		echo "This script only supports Ubuntu 14.04 LTS Trusty Thar"
		exit 2
fi

#exit if github is not reachable
if ping -c 3 github.com
	then
		echo "preparing system...please wait"
		apt-get install -y git git-core > /dev/null
		rm -r /tmp/* > /dev/null
		git clone https://github.com/uk3k/kodi_aio.git /tmp >
		chmod -R +x /tmp/*
		. /tmp/kodi_aio_setup.sh
	else
		echo "Github.com is not reachable, please check your internet connection or try again later."
		echo "This script can't be used as long Github.com is not reachable"
		echo "or neither your internet connection isn't working correctly."
		exit 3	
fi
