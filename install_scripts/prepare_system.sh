#!/bin/bash
#ensure system is up to date

apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get install -y unzip linux-firmware-nonfree python-software-properties software-properties-common udisks upower xorg alsa-utils mesa-utils git-core librtmp0 lirc libmad0 lm-sensors libmpeg2-4 avahi-daemon libnfs1 consolekit pm-utils

