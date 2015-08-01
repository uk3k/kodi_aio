#!/bin/bash

if [ "$sys_type" = "host" ]
	then

#samba configuration file
cat > /etc/samba/smb.conf <<smbconf
[global]
	workgroup = NETWORK
	server string = kodi_host
	socket options = TCP_NODELAY
  interfaces = $primary_iface
	bind interfaces only = yes
  log file = /var/log/samba/log.%m
	max log size = 1000
	security = share
	map to guest = bad user
	bad user = nobody

[OSCAM]
	comment = OSCAM configuration files
	path = /usr/local/etc
	browseable = yes
	guest ok = yes
	public = yes
	writeable = yes
	create mask = 0775
	directory mask = 0775

[VDR]
	comment = VDR configuration files
	path = /var/lib/vdr
	browseable = yes
	guest ok = yes
	public = yes
	writeable = yes
	create mask = 0775
	directory mask = 0775

[SAMBA]
	comment = Samba configuration files
	path = /etc/samba
	browseable = yes
	guest ok = yes
	public = yes
	writeable = yes
	create mask = 0775
	directory mask = 0775	
	
[Movies]
  comment = Movies
	path = /media/Movies
	browseable = yes
	guest ok = yes
	public = yes
	writeable = yes
	create mask = 0775
	directory mask = 0775	

[TV-Shows]
  comment = TV-Shows
	path = /media/TV-Shows
	browseable = yes
	guest ok = yes
	public = yes
	writeable = yes
	create mask = 0775
	directory mask = 0775	

[Music]
  comment = Music
	path = /media/Music
	browseable = yes
	guest ok = yes
	public = yes
	writeable = yes
	create mask = 0775
	directory mask = 0775
	
[Pictures]
  comment = Pictures
	path = /media/Pictures
	browseable = yes
	guest ok = yes
	public = yes
	writeable = yes
	create mask = 0775
	directory mask = 0775	
smbconf

#create mountpoints/shared folders
mkdir -p /media/Movies /media/TV-Shows /media/Music /media/Pictures

#set samba permissions
chmod 775 /etc/samba/smb.conf
chmod -R 775 /media/Movies /media/TV-Shows /media/Music /media/Pictures

fi
