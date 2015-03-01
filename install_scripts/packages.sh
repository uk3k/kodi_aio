#!/bin/bash

#ensure system is up to date
apt-add-repository ppa:team-xbmc/ppa -y
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

#define packages to install
basepkg
gfxpkg
kodipkg
mysqlpkg
vdrpkg
oscampkg
pyloadpkg

