#!/bin/bash
#read actual network configuration

#get primary network interface
#if there's no iface configured in /etc/network/interfaces use the first active NIC (link-up) with a valid ipv4 address
nw_iface=$(awk '{ print }' /etc/network/interfaces | grep iface | grep inet | grep dhcp | awk '{ print $2 }')
nw_active_iface=$(ip addr show | awk '/state UP/' | awk '{print $2}' | grep -m 1 : |sed s/:.*//) 
if [ "$nw_active_iface" != "$nw_iface" ]
	then
		nw_iface=$active_iface
fi

#get assigned ip-address
nw_ip=$(ip addr show | grep inet | grep $nw_iface | awk '{ print $2 }' | awk '{gsub("/24", "");print}')

#get netmask
nw_netmask=$(ifconfig $nw_iface | grep inet | grep 192 | sed s/^.*Mask.*://)

#get default gateway
nw_gateway=$(route -n | grep 'UG[ \t]' | awk '{print $2}')

#define nameservers
nw_dns1=$gateway
nw_dns2="8.8.8.8"

#check if there is a standard wifi-adapter
nw_wifi_present=$(ifconfig -a | grep ^wlan.*)

if [ -z "$nw_wifi_present" ]
	then
		nw_wifi_present=false
	else
		nw_wifi_present=true
fi

#check if wifi was allready configured by ubiquity
nw_wifi_configured=$(cat /etc/network/interfaces | grep wpa-ssid)
if [ -z "$nw_wifi_configured" ]
	then
		nw_use_wifi=false
	else
		nw_use_wifi=true
fi

#read wifi access
if [ "$nw_use_wifi" = "true" ] 
	then 
		nw_wifi_ssid=$(cat /etc/network/interfaces | grep wpa-ssid | awk '{ print $2 }')
		nw_wifi_psk=$(cat /etc/network/interfaces | grep wpa-psk | awk '{ print $2 }')
fi
