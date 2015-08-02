#!/bin/bash
#print summary to txt-file before executing installer
#V1.0.0.0.A

echo "General Information" > /home/kodi/summary.txt
echo "Bug Reports:            github@uk3k.de" >> /home/kodi/summary.txt
echo "Script-Version:         $script_version" >> /home/kodi/summary.txt
echo "Ubuntu Release:         $sys_os" >> /home/kodi/summary.txt
echo "System type to install: $sys_type" >> /home/kodi/summary.txt
echo "Setup mode:             $setup" >> /home/kodi/summary.txt
echo "Grapics Vendor:         $sys_gfx" >> /home/kodi/summary.txt
echo "-----------------------------" >> /home/kodi/summary.txt

echo "Network Configuration" >> /home/kodi/summary.txt
echo "Primary Network Interface:  $nw_iface" >> /home/kodi/summary.txt
echo "IP-Address Settings:        $nw_mode" >> /home/kodi/summary.txt
echo "Wifi Adapter present:       $nw_wifi_present" >> /home/kodi/summary.txt
echo "Use Wifi connection:        $nw_use_wifi" >> /home/kodi/summary.txt
echo "Wifi SSID:                  $nw_wifi_ssid" >> /home/kodi/summary.txt
echo "Wifi PSK:                   $nw_wifi_psk" >> /home/kodi/summary.txt
echo "IP-Address:                 $nw_ip" >> /home/kodi/summary.txt
echo "Netmask:                    $nw_netmask" >> /home/kodi/summary.txt
echo "Gateway:                    $nw_gateway" >> /home/kodi/summary.txt
echo "Nameserver #1:              $nw_dns1" >> /home/kodi/summary.txt
echo "Nameserver #2:              $nw_dns2" >> /home/kodi/summary.txt
echo "-----------------------------" >> /home/kodi/summary.txt

echo "Mysql Settings" >> /home/kodi/summary.txt
echo "Mysql-Server-IP:      $sql_ip" >> /home/kodi/summary.txt
echo "Mysql Root Password:  $sql_rootpw" >> /home/kodi/summary.txt
echo "Mysql User Password:  $sql_userpw" >> /home/kodi/summary.txt
echo "-----------------------------" >> /home/kodi/summary.txt

echo "Live-TV Selections" >> /home/kodi/summary.txt
echo "TV-Card detected:                                   $tv_tvcard_present" >> /home/kodi/summary.txt
echo "Install Live-TV support:                            $tv_vdr" >> /home/kodi/summary.txt
echo "DVB-Type:                                           $tv_dvb_type" >> /home/kodi/summary.txt
echo "Install local PayTV descrambling support (OSCAM):   $tv_oscam" >> /home/kodi/summary.txt
echo "Preconfigure OSCAM for your PayTV-Provider:         $tv_precfg_oscam" >> /home/kodi/summary.txt
echo "Selected PayTV-Provider:                            $tv_provider" >> /home/kodi/summary.txt
echo "Selected Smart-Card-Reader vendor:                  $tv_cardreader" >> /home/kodi/summary.txt
echo "Bus:ID of your Smart-Card-Reader:                   $tv_cr_busid (000:000=dummy)" >> /home/kodi/summary.txt
echo "Scan for available TV-Channels:                     $tv_scan" >> /home/kodi/summary.txt
echo "-----------------------------" >> /home/kodi/summary.txt

echo "Additional Packages" >> /home/kodi/summary.txt
echo "Install Pyload Download-Manager:  $add_pyload" >> /home/kodi/summary.txt
echo "-----------------------------" >> /home/kodi/summary.txt

clear
#debug
cat /home/kodi/summary.txt
