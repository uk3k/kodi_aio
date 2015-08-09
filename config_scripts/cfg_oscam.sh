#!/bin/bash
###tweaks for oscam

if [ "$tv_oscam" = "true" ]
	then
	
#create folder for oscam configs
mkdir -p /usr/local/etc/

#create oscam.conf
cat > /usr/local/etc/oscam.conf <<oscamconf
[global]
usrfile                       = /var/log/oscam/oscamuser.log
logfile                       = /var/log/oscam/oscam.log
cwlogdir                      = /var/log/oscam/cw
nice                          = -1

[monitor]
port                          = 988
aulow                         = 120
hideclient_to                 = 15
monlevel                      = 1

[dvbapi]
enabled			= 1
boxtype			= pc
user 				= vdr
au				= 1
pmt_mode			= 1
request_mode 			= 1

[webif]
httpport                      = 9999
httpuser                      = vdr
httppwd                       = vdr
httpallowed                   = 127.0.0.1,192.168.0.0-192.168.255.255

[anticasc]
enabled                       = 0
numusers                      = 1
samples                       = 5
penalty                       = 1
aclogfile                     = /var/log/oscam/aclog.log
denysamples                   = 4
oscamconf

#create oscam.dvbapi
cat > /usr/local/etc/oscam.dvbapi <<oscamdvbapi
#
# dvbapi configuration
#
# format:
#
#  priority:
#   P: CAID[:][provider ID][:][service ID][:][ECM PID] [continue]
#
#  ignore:
#   I: CAID[:][provider ID][:][service ID][:][ECM PID]
#
#  wait:
#   D: CAID[:][provider ID][:][service ID][:][ECM PID] delay
#
#  map:
#   M: CAID[:][provider ID][:][service ID][:][ECM PID] target CAID[:][target provider ID]
#
#  lenght:
#   L: CAID[:][provider ID][:][service ID][:][ECM PID] length
#

P: 098e 1
oscamdvbapi

#create oscam.server
cat > /usr/local/etc/oscam.server <<oscamserver
#
# reader configuration
#

[reader]
label			= KBW
protocol		= smartreader
device			= $tv_cr_busid
caid			= 098E
detect			= cd
boxid			= 12345678
mhz			= 357
cardmhz		= 357
group			= 1
emmcache		= 1,3,2
oscamserver

#create oscam.user
cat > /usr/local/etc/oscam.user <<oscamuser
[account]
user                          = vdr
pwd                           = dummy
group                         = 1
au                            = KBW
caid		 	         = 098E
oscamuser

#create upstart-script
cat > /etc/init/oscam.conf <<upstart
#oscam-upstart

description     "OSCAM Card-Server"
author          "Paul Krause"

start on (local-filesystems and net-device-up IFACE!=lo)
stop on runlevel [!2345]

exec /usr/local/bin/oscam -c /usr/local/etc/
upstart

###create oscam logging dir
mkdir -p /var/log/oscam
chmod -R 775 /var/log/oscam/


#cfg permissions for samba
chmod -R 775 /usr/local/etc/*
fi
