#!/bin/bash
#determine actual operating system
#V1.0.0.0.A

sys_os=$(lsb_release -c | awk '{ print $2 }')
