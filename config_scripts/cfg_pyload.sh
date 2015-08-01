#!/bin/bash
###tweaks for pyload

if [ "$add_pyload" = "true" ]
  then
    clear
		echo -e "running initial pyload setup... "
		sudo -u kodi -H /usr/bin/pyLoadCore
fi
