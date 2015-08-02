#!/bin/bash
#use this one as management script to call all modules

#version
script_version="1.0 Alpha"

#working dir
install="/tmp/kodi_aio"

#path to install scripts
scripts="$install/install_scripts"

#path to config scripts
config="$install/config_scripts"

#path to user dialog scripts
dialog="$install/dialog_scripts"

#path to hardware detection scripts
hw="$install/hw_detect"

#start user dialog
. $dialog/welcome.sh

###debug
exit 0

#run install scripts
. $scripts/install_base-packages.sh
. $scripts/install_live-tv.sh
. $scripts/install_additional.sh

#run config scripts
. $config/cfg_gfx.sh
. $config/cfg_network.sh
. $config/cfg_samba.sh
. $config/cfg_mysql.sh
. $config/cfg_kodi.sh
. $config/cfg_vdr.sh
. $config/cfg_oscam.sh
. $config/cfg_pyload.sh
. $config/cfg_alsa.sh

#clean up
. $scripts/install_cleanup.sh
