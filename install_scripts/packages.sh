#!/bin/bash

#ensure system is up to date
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

#add ppas
apt-add-repository ppa:team-xbmc/ppa -y
