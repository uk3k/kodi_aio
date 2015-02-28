#!/bin/bash
#install vdr and compile dvbapi plugin
if [ "$target" = "host" ] && [ "$live_tv" = "true" ]
	then
		add-apt-repository -y ppa:aap/vdr
		apt-get update
		apt-get upgrade -y
		apt-get install -y vdr vdr-dev vdr-plugin-streamdev-server vdr-plugin-dvbapi w-scan git-core pkg-config libtool tsdecrypt libdvbcsa-dev libdvbcsa1 libusb-1.0-0 libusb-1.0-0-dev openssl libssl-dev libncurses5-dev subversion cmake	
		apt-get build-dep -y vdr
		cd $install/src/
		git clone git://projects.vdr-developer.org/vdr.git
		cd $install/src/vdr/PLUGINS/src
		git clone https://github.com/FernetMenta/vdr-plugin-vnsiserver
		ln -s vdr-plugin-vnsiserver vnsiserver
		cd $install/src/vdr
		make -j2
		make install
		vnsiversion=$(ls /usr/local/lib/vdr/ | grep vnsi | grep 2.* | awk '{gsub("libvdr-vnsiserver.so.", "");print}')
		ln -s /usr/local/lib/vdr/libvdr-vnsiserver.so.$vnsiversion /usr/lib/vdr/plugins/libvdr-vnsiserver5.so.$vnsiversion
fi

useradd vdr
usermod -a -G video vdr
mkdir -p /var/vdr /var/vdr/record /etc/vdr/plugins/vnsiserver /etc/vdr/plugins/xvdr /etc/vdr/plugins/streamdev
chown -R :video /var/vdr
chmod -R g+w /var/vdr
apt-get install -y build-essential libjpeg62-dev libcap-dev libfontconfig1-dev gettext libncursesw5-dev libncurses5-dev
apt-get build-dep -y vdr
cd /$install/src
#get vdr source
git clone git://projects.vdr-developer.org/vdr.git
cd /$install/src/vdr/PLUGINS/src
#get plugin sources (streamdev, vnsi, xvdr, dvbapi, epgsync, svdrpservice)
git clone git://projects.vdr-developer.org/vdr-plugin-streamdev.git
git clone https://github.com/FernetMenta/vdr-plugin-vnsiserver
git clone https://github.com/pipelka/vdr-plugin-xvdr.git
git clone https://github.com/manio/vdr-plugin-dvbapi.git
wget http://vdr.schmirler.de/epgsync/vdr-epgsync-1.0.1.tgz
wget http://vdr.schmirler.de/svdrpservice/vdr-svdrpservice-1.0.0.tgz
tar -xzf vdr-epgsync-1.0.1.tgz
tar -xzf vdr-svdrpservice-1.0.0.tgz
rm *.tgz
ln -s vdr-plugin-streamdev streamdev
ln -s vdr-plugin-vnsiserver vnsiserver
ln -s vdr-plugin-xvdr xvdr
ln -s vdr-plugin-dvbapi dvbapi
ln -s vdr-epgsync-1.0.1 epgsync
ln -s svdrpservice-1.0.0 svdrpservice
cd ../../
make -j2 && make install
#link plugins?
#####
#copy configs
cp diseqc.conf /etc/vdr
cp sources.conf /etc/vdr
sudo cp runvdr.template /usr/local/bin/runvdr
#autostart script
cat > /etc/init/vdr.conf <<vdrconf
description "vdr"
start on (local-filesystems
     and net-device-up IFACE=lo
   and dvb-ready)

stop on runlevel [!2345]
nice -1

pre-start script
  while [ ! -e /dev/dvb/adapter0/frontend0 ]
  do
    sleep 1
  done
end script

script
  su -c /usr/local/bin/runvdr vdr > /var/log/vdr.log 2>&1
end script
vdrconf
#udev rule for dvb-card detection
cat > /etc/udev/rules.d/85-vdr.rules <<dvbdetection
#DVB
SUBSYSTEM=="dvb" , KERNEL=="dvb0.frontend0", ACTION=="add", RUN+="/sbin/initctl --quiet emit --no-wait dvb-ready"
dvbdetection
#create channels.conf
cat > /etc/vdr/channels.conf <<channels
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
#create allowed_hosts.conf
echo "192.168.1.0/24" > /etc/vdr/allowed_hosts.conf
#link allowed_hosts.conf
ln -s /etc/vdr/allowed_hosts.conf /etc/vdr/svdrphosts.conf
ln -s /etc/vdr/allowed_hosts.conf /etc/vdr/plugins/vnsiserver/allowed_hosts.conf 
ln -s /etc/vdr/allowed_hosts.conf /etc/vdr/plugins/xvdr/allowed_hosts.conf 
ln -s /etc/vdr/allowed_hosts.conf /etc/vdr/plugins/streamdev/allowed_hosts.conf 

