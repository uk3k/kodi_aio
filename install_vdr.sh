#!/bin/bash
#install vdr & plugins from source

#run this script as root or it will fail!
#only for testing! Delete network detection from script when using it finally
###internal test with picostick
wget http://www.kernellabs.com/firmware/as102/as102_data1_st.hex
wget http://www.kernellabs.com/firmware/as102/as102_data2_st.hex
cp as102_data* /lib/firmware
rm as102_data*
install="/tmp/kodi_aio/"
primary_iface=$(awk '{ print }' /etc/network/interfaces | grep iface | grep inet | grep dhcp | awk '{ print $2 }')
active_iface=$(ip addr show | awk '/state UP/' | awk '{print $2}' | grep -m 1 : |sed s/:.*//) 
if [ "$active_iface" != "$primary_iface" ]
	then
		primary_iface=$active_iface
fi
ip_addr=$(ip addr show | grep inet | grep $primary_iface | awk '{ print $2 }' | awk '{gsub("/24", "");print}')
localnet=$(echo "$ip_addr" | awk -F '.' '{gsub($4, "0/24");print}')
#

#the actual script starts here
useradd vdr
usermod -a -G video vdr
mkdir -p $install/src /var/vdr /var/vdr/record /var/lib/vdr/plugins/vnsiserver /var/lib/vdr/plugins/streamdev-server /etc/vdr/plugins/vnsiserver /etc/vdr/plugins/streamdev-server 
chown -R :video /var/vdr /var/lib/vdr/
chmod -R g+w /var/vdr /var/lib/vdr/
apt-get install -y build-essential libjpeg62-dev libcap-dev libfontconfig1-dev gettext libncursesw5-dev libncurses5-dev
apt-get build-dep -y vdr
cd /$install/src
git clone git://projects.vdr-developer.org/vdr.git
cd /$install/src/vdr/PLUGINS/src
#get plugin sources (streamdev, vnsi, dvbapi, svdrpservice)
git clone git://projects.vdr-developer.org/vdr-plugin-streamdev.git
git clone https://github.com/FernetMenta/vdr-plugin-vnsiserver
git clone https://github.com/manio/vdr-plugin-dvbapi.git
wget http://vdr.schmirler.de/svdrpservice/vdr-svdrpservice-1.0.0.tgz
tar -xzf vdr-svdrpservice-1.0.0.tgz
rm *.tgz
ln -s vdr-plugin-streamdev streamdev
ln -s vdr-plugin-vnsiserver vnsiserver
ln -s vdr-plugin-dvbapi dvbapi
ln -s svdrpservice-1.0.0 svdrpservice
cd ../../
make -j2 && make install
cat > /usr/local/bin/runvdr <<runvdr
#!/bin/sh
#vdr run options file

#path to binary
VDRPRG="/usr/local/bin/vdr"
#options
VDROPTIONS="-w 60 --video=/var/vdr/record --epgfile=/var/vdr/epg.data export VDR_CHARSET_OVERRIDE="ISO-8859-15""
#plugins
VDRPLUGINS="-P vnsiserver -P dvbapi -P streamdev-server -P svdrpservice"

#the command itself
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
#create allowed_hosts.conf
echo "$localnet	#any host on the local net" > /var/lib/vdr/allowed_hosts.conf
echo "$localnet	#any host on the local net" > /var/lib/vdr/svdrphosts.conf
echo "$localnet	#any host on the local net" > /var/lib/vdr/plugins/vnsiserver/allowed_hosts.conf
echo "$localnet	#any host on the local net" > /var/lib/vdr/plugins/streamdev-server/streamdevhosts.conf
ln -s /var/lib/vdr/allowed_hosts.conf /etc/vdr/allowed_hosts.conf
ln -s /var/lib/vdr/svdrphosts.conf /etc/vdr/svdrphosts.conf
ln -s /var/lib/vdr/plugins/vnsiserver/allowed_hosts.conf /etc/vdr/plugins/vnsiserver/allowed_hosts.conf 
ln -s /var/lib/vdr/plugins/streamdev-server/streamdevhosts.conf /etc/vdr/plugins/streamdev-server/streamdevhosts.conf 

###########################put the following in the config script for vdr!!!! ##################################
#autostart script
cat > /etc/init/vdr.conf <<vdrconf
# vdr upstart script

description     "´linux video disk recorder"
author          "Rainer Hochecker/Paul Krause"

start on (filesystem and net-device-up IFACE!=lo and dvb-ready)
stop on runlevel [!2345]
nice -1

script
        su -c /usr/local/bin/runvdr vdr > /var/log/vdr.log 2>&1
end script
vdrconf

#make script executable
chmod +x /etc/init/vdr.conf

#udev rule for dvb-card detection
cat > /etc/udev/rules.d/85-vdr.rules <<dvbdetection
#DVB
SUBSYSTEM=="dvb" , KERNEL=="dvb0.frontend0", ACTION=="add", RUN+="/sbin/initctl --quiet emit --no-wait dvb-ready"
dvbdetection

#create channels.conf
cat > /var/lib/vdr/channels.conf <<channels
#enter new content
channels
ln -s /var/lib/vdr/channels.conf /etc/vdr/channels.conf
