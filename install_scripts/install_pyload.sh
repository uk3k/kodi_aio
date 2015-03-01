#!/bin/bash
if [ "$pyload" = "true" ]
  then
    wget http://download.pyload.org/pyload-v0.4.9-all.deb
		dpkg -i pyload*.deb
fi
