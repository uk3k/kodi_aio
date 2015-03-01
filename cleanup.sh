#!/bin/bash
###clean up after setup is done

rm -R $install
apt-get -y autoremove
apt-get -y autoclean
echo "" > /root/.bashrc
