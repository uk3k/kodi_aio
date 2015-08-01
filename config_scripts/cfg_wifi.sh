#!/bin/bash
###tweaks for wifi

if [ "$nw_use_wifi" = "true" ]
	then

#create wpasupplicant.conf
cat > /etc/wpa_supplicant/wpa_supplicant.conf <<wpasupplicantconf
###the base config, do not modify!

ctrl_interface=/var/run/wpa_supplicant
eapol_version=1
ap_scan=1

#ap specific config
wpasupplicantconf

echo "wpa_passphrase $nw_wifi_ssid $nw_wifi_psk" >> /etc/wpa_supplicant/wpa_supplicant.conf

# append wifi settings to /etc/network/interfaces
cat >> /etc/network/interfaces <<interfaces

#wireless conf for wlan0
auto wlan0
iface wlan0 inet dhcp
	wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
interfaces

fi
