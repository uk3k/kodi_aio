#!/bin/bash
###tweaks for vdr

# vdr.groups
cat > /var/lib/vdr/vdr.groups <<vdrgroups
vdr
video
vdrgroups

if [ "$live_tv" = "true" ]
  then
    #create vdr-parameter-script
    cat > /usr/local/bin/runvdr <<runvdr
#!/bin/sh
#vdr run options file
#path to binary
VDRPRG="/usr/local/bin/vdr"
#options
VDROPTIONS="-w 60 --video=/var/vdr/record --epgfile=/var/vdr/epg.data export VDR_CHARSET_OVERRIDE="ISO-8859-15""
#plugins
VDRPLUGINS="-P vnsiserver -P dvbapi -P streamdev-server -P svdrpservice"
#parameter comand
VDRCMD="\$VDRPRG \$VDROPTIONS \$VDRPLUGINS \$*"
      
KILL="/usr/bin/killall -q -TERM"
# Detect whether the DVB driver is already loaded
# and return 0 if it *is* loaded, 1 if not:
DriverLoaded()
  {
    return 1
  }
# Load all DVB driver modules needed for your hardware:
LoadDriver()
  {
    return 0
  }
# Unload all DVB driver modules loaded in LoadDriver():
UnloadDriver()
  {
    return 0
  }
# Load driver if it hasn't been loaded already:
if ! DriverLoaded; then
  LoadDriver
fi
while (true) do
  eval "\$VDRCMD"
  if test \$? -eq 0 -o \$? -eq 2; then exit; fi
  echo "`date` reloading DVB driver"
  \$KILL \$VDRPRG
  sleep 10
  UnloadDriver
  LoadDriver
  echo "`date` restarting VDR"
done
runvdr

chmod +x /usr/local/bin/runvdr

#create access rules for vdr
echo "$localnet	#any host on the local net" > /var/lib/vdr/allowed_hosts.conf
echo "$localnet	#any host on the local net" > /var/lib/vdr/svdrphosts.conf
echo "$localnet	#any host on the local net" > /var/lib/vdr/plugins/vnsiserver/allowed_hosts.conf
echo "$localnet	#any host on the local net" > /var/lib/vdr/plugins/streamdev-server/streamdevhosts.conf
ln -s /var/lib/vdr/allowed_hosts.conf /etc/vdr/allowed_hosts.conf
ln -s /var/lib/vdr/svdrphosts.conf /etc/vdr/svdrphosts.conf
ln -s /var/lib/vdr/plugins/vnsiserver/allowed_hosts.conf /etc/vdr/plugins/vnsiserver/allowed_hosts.conf 
ln -s /var/lib/vdr/plugins/streamdev-server/streamdevhosts.conf /etc/vdr/plugins/streamdev-server/streamdevhosts.conf 

#scan for tv channels
if [ "$w_scan" = "true" ]
	then
		if [ "$scan_type" = "c" ] || [ "$scan_type" = "s" ] || [ "$scan_type" = "t" ]
			then
				w_scan -R0 -T1 -f $scantype > /var/lib/vdr/channels.conf
		fi
fi

#set permissions for samba
chmod -R 775 /var/lib/vdr/* 
