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
mkdir -p $install/src /var/vdr /var/vdr/record /var/lib/vdr/plugins/vnsiserver /var/lib/vdr/plugins/streamdev-server /etc/vdr/plugins/vnsiserver /etc/vdr/plugins/streamdev 
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
tar -xzf vdr-epgsync-1.0.1.tgz
tar -xzf vdr-svdrpservice-1.0.0.tgz
rm *.tgz
ln -s vdr-plugin-streamdev streamdev
ln -s vdr-plugin-vnsiserver vnsiserver
ln -s vdr-plugin-dvbapi dvbapi
ln -s vdr-epgsync-1.0.1 epgsync
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
rm /var/lib/vdr/svdrphosts.conf /var/lib/vdr/allowed_hosts.conf
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

pre-start script
        while [ ! -e /dev/dvb/adaptert0/frontend0 ]
        do
                sleep 1
        done
end script

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
ZDF;ZDFmobil:490000:I999B8C999D999M999T999G999Y999:T:27500:545:546=deu,547=mis:551:0:514:0:0:0
3sat;ZDFmobil:490000:I999B8C999D999M999T999G999Y999:T:27500:561:562=deu,563=mis:567:0:515:0:0:0
neo/KiKa;ZDFmobil:490000:I999B8C999D999M999T999G999Y999:T:27500:593:594=deu:599:0:517:0:0:0
ZDFinfokanal;ZDFmobil:490000:I999B8C999D999M999T999G999Y999:T:27500:577:578=deu:551:0:516:0:0:0
ZDF;ZDFmobil:570000:I999B8C23D0M16T8G4Y0:T:27500:545:546=deu,547=mis:551:0:514:8468:514:0
3sat;ZDFmobil:570000:I999B8C23D0M16T8G4Y0:T:27500:561:562=deu,563=mis:567:0:515:8468:514:0
neo/KiKa;ZDFmobil:570000:I999B8C23D0M16T8G4Y0:T:27500:593:594=deu:599:0:517:8468:514:0
ZDFinfokanal;ZDFmobil:570000:I999B8C23D0M16T8G4Y0:T:27500:577:578=deu:551:0:516:8468:514:0
arte;SWR:514000:I999B8C999D999M999T999G999Y999:T:27500:513:514=deu,515=fre:516:0:2:0:0:0
Phoenix;SWR:514000:I999B8C999D999M999T999G999Y999:T:27500:769:770=deu:772:0:3:0:0:0
EinsPlus;SWR:514000:I999B8C999D999M999T999G999Y999:T:27500:1025:1026=deu:1028:0:6:0:0:0
Das Erste;SWR:514000:I999B8C999D999M999T999G999Y999:T:27500:257:258=deu,259=mis:260:0:224:0:0:0
Bayerisches FS;SWR:706000:I999B8C23D0M16T8G4Y0:T:27500:1025:1026=deu:1028:0:34:8468:6144:0
hr-fernsehen;SWR:706000:I999B8C23D0M16T8G4Y0:T:27500:513:514=deu:516:0:65:8468:6144:0
SWR Fernsehen BW;SWR:706000:I999B8C23D0M16T8G4Y0:T:27500:257:258=deu,259=mis:260:0:225:8468:6144:0
WDR Fernsehen;SWR:706000:I999B8C23D0M16T8G4Y0:T:27500:769:770=deu:772:0:262:8468:6144:0
RTL Television;CBC:666000:I999B8C34D0M16T8G8Y0:T:27500:337:0:343:b00:16405:8468:9474:0
RTL2;CBC:666000:I999B8C34D0M16T8G8Y0:T:27500:353:0:359:b00:16406:8468:9474:0
Super RTL;CBC:666000:I999B8C34D0M16T8G8Y0:T:27500:433:0:439:b00:16411:8468:9474:0
VOX;CBC:666000:I999B8C34D0M16T8G8Y0:T:27500:545:0:551:b00:16418:8468:9474:0
RTL Crime;CBC:666000:I999B8C34D0M16T8G8Y0:T:27500:705:0:0:b00:16428:8468:9474:0
Passion;CBC:666000:I999B8C34D0M16T8G8Y0:T:27500:721:0:0:b00:16429:8468:9474:0
channels
ln -s /var/lib/vdr/channels.conf /etc/vdr/channels.conf
