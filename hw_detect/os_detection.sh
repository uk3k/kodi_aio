#!/bin/bash
#determine actual operating system

sys_os=$(lsb_release -c | awk '{ print $2 }')
