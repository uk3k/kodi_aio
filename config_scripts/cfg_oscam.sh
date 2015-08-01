#!/bin/bash
###tweaks for oscam

if [ "$tv_oscam" = "true" ]
	then
	
#create folder for oscam configs
mkdir -p /usr/local/etc/

#create oscam.conf
cat > /usr/local/etc/oscam.conf <<oscamconf
[global]
usrfile                       = /var/log/oscam/oscamuser.log
logfile                       = /var/log/oscam/oscam.log
cwlogdir                      = /var/log/oscam/cw
nice                          = -1

[monitor]
port                          = 988
aulow                         = 120
hideclient_to                 = 15
monlevel                      = 1

[dvbapi]
enabled			= 1
boxtype			= pc
user 				= vdr
au				= 1
pmt_mode			= 1
request_mode 			= 1

[webif]
httpport                      = 9999
httpuser                      = vdr
httppwd                       = vdr
httpallowed                   = 127.0.0.1,192.168.0.0-192.168.255.255

[anticasc]
enabled                       = 0
numusers                      = 1
samples                       = 5
penalty                       = 1
aclogfile                     = /var/log/oscam/aclog.log
denysamples                   = 4
oscamconf

#create oscam.dvbapi
cat > /usr/local/etc/oscam.dvbapi <<oscamdvbapi
#
# dvbapi configuration
#
# format:
#
#  priority:
#   P: CAID[:][provider ID][:][service ID][:][ECM PID] [continue]
#
#  ignore:
#   I: CAID[:][provider ID][:][service ID][:][ECM PID]
#
#  wait:
#   D: CAID[:][provider ID][:][service ID][:][ECM PID] delay
#
#  map:
#   M: CAID[:][provider ID][:][service ID][:][ECM PID] target CAID[:][target provider ID]
#
#  lenght:
#   L: CAID[:][provider ID][:][service ID][:][ECM PID] length
#

P: 098e 1
oscamdvbapi

#create oscam.server
cat > /usr/local/etc/oscam.server <<oscamserver
#
# reader configuration
#

[reader]
label			= KBW
protocol		= smartreader
device			= $busid
caid			= 098E
detect			= cd
boxid			= 12345678
mhz			= 357
cardmhz		= 357
group			= 1
emmcache		= 1,3,2
oscamserver

#create oscam.user
cat > /usr/local/etc/oscam.user <<oscamuser
[account]
user                          = vdr
pwd                           = dummy
group                         = 1
au                            = KBW
caid		 	         = 098E
oscamuser

#create upstart-script
cat > /etc/init.d/oscam <<upstart
#!/bin/sh

DAEMON=/usr/local/bin/oscam
DEAMON_OPTS="-c /usr/local/etc/"
PIDFILE=/var/run/oscam.pid

test -x \${DAEMON} || exit 0

. /lib/lsb/init-functions


get_status()
{
    if start-stop-daemon --start --startas \$DAEMON --test \
        --name \$(basename \$DAEMON) --pidfile \$PIDFILE >/dev/null
    then
        echo " - is not running."
        exit 3
    else
        echo " - is running."
        exit 0
    fi
}


case "\$1" in
  start)
        log_daemon_msg "Starting OScam"
        start-stop-daemon --start --quiet --background --pidfile \${PIDFILE} --make-pidfile --exec \${DAEMON} -- \${DEAMON_OPTS} 
        log_end_msg \$?
    ;;
  stop)
        log_daemon_msg "Stopping OScam"
        start-stop-daemon --stop --exec \${DAEMON}
        log_end_msg \$?
    ;;
  force-reload|restart)
        \$0 stop
        \$0 start
    ;;
  reload)
        killall -HUP \${DAEMON}
    ;;
  status)
        echo -n "Getting status of oscam"
        get_status
        ;;

  *)  
    echo "Usage: \$0 {start|stop|restart|force-reload|status|reload}"
    exit 1
    ;;
esac

exit 0
upstart

###create oscam logging dir
mkdir -p /var/log/oscam
chmod -R 775 /var/log/oscam/


###enable init-script for oscam
chmod +x /etc/init.d/oscam
update-rc.d oscam defaults

#cfg permissions for samba
chmod -R 775 /usr/local/etc/*
fi
