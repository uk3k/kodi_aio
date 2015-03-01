#!/bin/bash
###read actual network configuration

#get primary network interface
#if there's no iface configured in /etc/network/interfaces use the first active NIC (link-up) with a valid ipv4 address
primary_iface=$(awk '{ print }' /etc/network/interfaces | grep iface | grep inet | grep dhcp | awk '{ print $2 }')
active_iface=$(ip addr show | awk '/state UP/' | awk '{print $2}' | grep -m 1 : |sed s/:.*//) 
if [ "$active_iface" != "$primary_iface" ]
	then
		primary_iface=$active_iface
fi

#get dhcp assigned address
ip_addr=$(ip addr show | grep inet | grep $primary_iface | awk '{ print $2 }' | awk '{gsub("/24", "");print}')

#get netmask
netmask=$(ifconfig $primary_iface | grep inet | grep 192 | sed s/^.*Mask.*://)

#get default gateway
gateway=$(route -n | grep 'UG[ \t]' | awk '{print $2}')

#define nameservers
dns1=$gateway
dns2="8.8.8.8"

#check if there is a standard wifi-adapter
wifi_present=$(ifconfig -a | grep ^wlan.*)

if [ -z "$wifi_present" ]
	then
		wifi_present=false
	else
		wifi_present=true
fi

#check if wifi was allready configured by ubiquity
wifi_configured=$(cat /etc/network/interfaces | grep wpa-ssid)
if [ -z "$wifi_configured" ]
	then
		wifi_configured=false
	else
		wifi_configured=true
fi

#read wifi access
if [ "$wifi_configured" = "true" ] 
	then 
		ssid=$(cat /etc/network/interfaces | grep wpa-ssid | awk '{ print $2 }')
		psk=$(cat /etc/network/interfaces | grep wpa-psk | awk '{ print $2 }')
fi
