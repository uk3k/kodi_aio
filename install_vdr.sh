#!/bin/bash
#install vdr and compile dvbapi plugin
if [ "$target" = "host" ] && [ "$live_tv" = "true" ]
	then
		add-apt-repository -y ppa:aap/vdr
		apt-get update
		apt-get upgrade -y
		apt-get install -y vdr vdr-dev vdr-plugin-streamdev-server vdr-plugin-dvbapi w-scan git-core pkg-config libtool tsdecrypt libdvbcsa-dev libdvbcsa1 libusb-1.0-0 libusb-1.0-0-dev openssl libssl-dev libncurses5-dev subversion cmake	
		apt-get build-dep -y vdr
		cd $install/src/
		git clone git://projects.vdr-developer.org/vdr.git
		cd $install/src/vdr/PLUGINS/src
		git clone https://github.com/FernetMenta/vdr-plugin-vnsiserver
		ln -s vdr-plugin-vnsiserver vnsiserver
		cd $install/src/vdr
		make -j2
		make install
		vnsiversion=$(ls /usr/local/lib/vdr/ | grep vnsi | grep 2.* | awk '{gsub("libvdr-vnsiserver.so.", "");print}')
		ln -s /usr/local/lib/vdr/libvdr-vnsiserver.so.$vnsiversion /usr/lib/vdr/plugins/libvdr-vnsiserver5.so.$vnsiversion
fi
