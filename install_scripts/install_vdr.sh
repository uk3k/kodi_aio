#!/bin/bash
if [ "$live_tv" = "true" ]
  then
  useradd vdr
  usermod -a -G video vdr
  mkdir -p $install/src /var/vdr /var/vdr/record /var/lib/vdr/plugins/vnsiserver /var/lib/vdr/plugins/streamdev-server /etc/vdr/plugins/vnsiserver /etc/vdr/plugins/streamdev-server 
  chown -R :video /var/vdr /var/lib/vdr/
  chmod -R g+w /var/vdr /var/lib/vdr/
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
fi
