#!/bin/bash

#Graphics vendor selection menu
input=`whiptail --backtitle "$headline" \
        --title "Graphics vendor" \
        --menu "\nSetup detected $sys_gfx as your graphics vendor. If this is incorrect select another one\n\nPlease Note: Selecting a wrong vendor may prevent the system from boot. \n
              Supported Vendors are:
		          Intel:   Every iGPU from Chipsets/CPUs since 2007 (Intel GMA 8xx; Intel HD2xxx; ...) 
		          AMD:     Every AMD/ATI (i)GPU since HD5xxx (HD5xxx; HD6xxx; E350; E450; E1200; ...)
		          NVIDIA:  Every NVIDIA (i)GPU since GeForce 2xx (GF2xx; GF3xx; GF4xx; ION; ...) \n\n " 30 100 2 \
                "Intel"     ""	\
                "AMD"       ""  \
                "NVIDIA"       ""	3>&1 1>&2 2>&3`
sys_gfx=$input
