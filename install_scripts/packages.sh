#!/bin/bash
###select and install packages available from repositories

#ensure system is up to date
apt-get install -y python-software-properties software-properties-common git git-core
apt-add-repository ppa:team-xbmc/ppa -y
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

#debconf preselection
echo "mysql-server mysql-server/root_password password $mysql_passwd" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $mysql_passwd" | debconf-set-selections

#define packages to install and preselect
#base packages
basepkg="linux-firmware linux-firmware-nonfree udisks upower xorg alsa-utils mesa-utils librtmp0 lirc libmad0 lm-sensors libmpeg2-4 avahi-daemon libnfs1 consolekit pm-utils samba "

#select gfx packages
if [ "$gfx" != "other" ]
	then
		gfxpkg="mesa-vdpau-drivers vdpauinfo "
		if [ "$gfx" = "INTEL" ]
			then
				gfxpkg="libva-intel-vaapi-driver libva1 vainfo libva-glx1 gtk2-engines-pixbuf "
		fi
		if [ "$gfx" = "NVIDIA" ]
			then
				gfxpkg="nvidia-current "
		fi
fi

#select kodi packages
kodipkg="kodi kodi-bin kodi-pvr-vdr-vnsi "

#select mysql packages
mysqlpkg="mysql-server "

#select vdr packages
if [ "$live_tv" = "true" ]
  then
    vdrpkg="build-essential libjpeg62-dev libcap-dev libfontconfig1-dev gettext libncursesw5-dev libncurses5-dev "
    apt-get build-dep -y vdr
fi

#select oscam packages
if [ "$oscam" = "true" ]
  then
    oscampkg="cmake subversion "
fi

#select pyload packages
if [ "$pyload" = "true" ]
  then
    pyloadpkg="python-crypto python-pycurl python-django openssl python-imaging python-beaker python-qt4 tesseract-ocr tesseract-ocr-eng gocr unrar rar "
fi    

#install packages
apt-get install -y $basepkg $gfxpkg $kodipkg $mysqlpkg $vdrpkg $oscampkg $pyloadpkg
