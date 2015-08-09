#!/bin/bash
#picostick for testing
wget http://www.kernellabs.com/firmware/as102/as102_data1_st.hex
wget http://www.kernellabs.com/firmware/as102/as102_data2_st.hex
cp as102_data* /lib/firmware
rm as102_data*

#check if system ready for setup
clear
echo "checking and preparing system...please wait"
#exit if script was not executed by user root (sudo doesn't work!)
[[ `id -u` -eq 0 ]] || { echo "Must be root to run script"; exit 1; }

#exit if operationg system is not Ubuntu 14.04
if [ "$(lsb_release -c | awk '{ print $2 }')" != "trusty" ]
	then
		echo "This script only supports Ubuntu 14.04 LTS Trusty Thar"
		exit 2
fi

#check if user kodi is allready present and add it if neccessary
if [ "$(cat /etc/passwd | grep kodi)" ]
        then
                if [ "$(ls /home | grep kodi)" ]
                        then
                                usermod -d /home/kodi kodi
                                chown kodi:kodi /home/kodi
                        else
                                mkdir -p /home/kodi
                                usermod -d /home/kodi kodi
                                chown kodi:kodi /home/kodi
                fi
        else
                useradd -U -m -s /bin/bash -p toor kodi
fi


#exit if github is not reachable
if ping -c 3 github.com > /dev/null
	then
		apt-get install -y git git-core > /dev/null
		rm -r /tmp/kodi_aio /tmp/kodi_aio/.git > /dev/null
		git clone https://github.com/uk3k/kodi_aio.git /tmp/kodi_aio
		chmod -R +x /tmp/* > /dev/null
		. /tmp/kodi_aio/kodi_aio_setup.sh
	else
		echo "Github.com is not reachable, please check your internet connection or try again later."
		echo "This script can't be used as long Github.com is not reachable"
		echo "or neither your internet connection isn't working correctly."
		exit 3	
fi
