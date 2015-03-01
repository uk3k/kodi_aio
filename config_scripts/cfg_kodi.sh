#!/bin/bash
###tweaks for kodi

#allow nice changing
echo "kodi             -       nice            -1" >> /etc/security/limits.conf

#create advancedsettings.xml
mkdir -p /home/kodi/.kodi/userdata
cat > /home/kodi/.kodi/userdata/advancedsettings.xml <<advset
<advancedsettings>
   <loglevel hide="false">0</loglevel>
  <cputempcommand>sensors|sed -ne "s/Core 0: \+[-+]\([0-9]\+\).*/\1 C/p"</cputempcommand>
  <gputempcommand>sensors|sed -ne "s/temp1: \+[-+]\([0-9]\+\).*/\1 C/p"</gputempcommand>
  <gui>    
    <algorithmdirtyregions>3</algorithmdirtyregions>
    <nofliptimeout>0</nofliptimeout>
  </gui>    
<video>
  <latency>
    <delay>0</delay>
    <refresh>
      <min>23</min>
      <max>24</max>
      <delay>0</delay> <!-- set to zero or adjust (i.e. 175) if audio seems out of sync with 24p movies -->
     </refresh>
  </latency>
</video>
<videodatabase>
	<type>mysql</type>
	<host>$mysql_host</host>
	<port>3306</port>
	<user>kodi</user>
	<pass>kodi</pass>
</videodatabase>
<musicdatabase>
	<type>mysql</type>
	<host>$mysql_host</host>
	<port>3306</port>
	<user>kodi</user>
	<pass>kodi</pass>
</musicdatabase>
<videolibrary>
	<importwatchedstate>true</importwatchedstate>
</videolibrary>
</advancedsettings>
advset

# create custom-actions.pkla
cat > /etc/polkit-1/localauthority/50-local.d/custom-actions.pkla <<custmaction
[Actions for kodi user]
Identity=unix-user:kodi
Action=org.freedesktop.upower.*;org.freedesktop.consolekit.system.*;org.freedesktop.udisks.*
ResultAny=yes
ResultInactive=yes
ResultActive=yes
custmaction

#upstart script
cat > /etc/init/kodi.conf <<kodiconf
# kodi-upstart
# starts kodi on startup by using xinit.
# by default runs as kodi, to change edit below.
env USER=kodi

description     "kodi-upstart-script"
author          "Matt Filetto"

start on (filesystem and stopped udevtrigger and net-device-up IFACE!=lo)
stop on runlevel [016]

# tell upstart to respawn the process if abnormal exit
respawn
respawn limit 10 5
limit nice 21 21

script
exec su -c "xinit /usr/bin/kodi --standalone :0" \$USER
end script
kodiconf

chmod +x /etc/init/kodi.conf

#set owner of kodi's homedir
chown -R kodi /home/kodi/
