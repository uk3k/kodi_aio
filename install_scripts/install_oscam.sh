#!/bin/bash
if [ "$oscam" = "true" ]
	then
		cd $install/src
		rm -R oscam*
		svn co http://streamboard.de.vu/svn/oscam/trunk oscam-svn
		cd oscam-svn*
		mkdir build
		cd build
		cmake .. -DHAVE_LIBUSB=1 -DWEBIF=1 -DHAVE_DVBAPI=1 -DCARDREADER_SMARGO=1 -DUSE_LIBUSB=1
		make -j3 && make install
fi
