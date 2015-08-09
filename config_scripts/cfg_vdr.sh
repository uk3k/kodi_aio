#!/bin/bash
###tweaks for vdr

if [ "$tv_vdr" = "true" ]
  then
# vdr.groups
cat > /var/lib/vdr/vdr.groups <<vdrgroups
vdr
video
vdrgroups

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

#create upstart script
cat > /etc/init/vdr.conf <<upstart
# vdr-upstart

description     "linux video disk recorder"
author          "Paul Krause"

start on (local-filesystems and net-device-up IFACE!=lo and dvb-ready)
stop on runlevel [!2345]

exec /usr/local/bin/runvdr vdr > /var/log/vdr.log 2>&1
upstart

#make scripts executable
chmod +x /usr/local/bin/runvdr

#create access rules for vdr
echo "$nw_loc_net	#any host on the local net" > /var/lib/vdr/allowed_hosts.conf
echo "$nw_loc_net	#any host on the local net" > /var/lib/vdr/svdrphosts.conf
echo "$nw_loc_net	#any host on the local net" > /var/lib/vdr/plugins/vnsiserver/allowed_hosts.conf
echo "$nw_loc_net	#any host on the local net" > /var/lib/vdr/plugins/streamdev-server/streamdevhosts.conf
ln -s /var/lib/vdr/allowed_hosts.conf /etc/vdr/allowed_hosts.conf
ln -s /var/lib/vdr/svdrphosts.conf /etc/vdr/svdrphosts.conf
ln -s /var/lib/vdr/plugins/vnsiserver/allowed_hosts.conf /etc/vdr/plugins/vnsiserver/allowed_hosts.conf 
ln -s /var/lib/vdr/plugins/streamdev-server/streamdevhosts.conf /etc/vdr/plugins/streamdev-server/streamdevhosts.conf 

#scan for tv channels
if [ "$tv_scan" = "true" ]
	then
		if [ "$tv_dvb_type" = "C" ] || [ "$tv_dvb_type" = "S" ] || [ "$tv_dvb_type" = "T" ]
			then
				w_scan -R0 -T1 -f $tv_dvb_type > /var/lib/vdr/channels.conf
		fi
fi

#set permissions for samba
chmod -R 775 /var/lib/vdr/* 
fi
