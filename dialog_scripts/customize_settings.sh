#!/bin/bash
#customize default settings

#network settings: primary networking interface
. $dialog/networking/iface_select.sh

#network settings: DHCP/Static
. $dialog/networking/network_settings.sh

#network settings: ip address
. $dialog/networking/ip_settings.sh

#network settings: netmask
. $dialog/networking/netmask_settings.sh

#network settings: gateway
. $dialog/networking/gateway_settings.sh

#network settings: Nameserver #1
. $dialog/networking/dns1_settings.sh

#network settings: Nameserver #2
. $dialog/networking/dns2_settings.sh

#network settings: wifi
. $dialog/networking/wifi_settings.sh
