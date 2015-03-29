#!bin/bash
#detect graphics vendor of the system
#V1.0.0.0.A

if [ "$(lspci | grep VGA | grep -o AMD)" != "AMD" ]
	then
		if [ "$(lspci | grep VGA | grep -o NVIDIA)" != "NVIDIA" ]
			then 
				sys_gfx=$(lspci | grep VGA | grep -o Intel)
			else
				sys_gfx="NVIDIA"
		fi
	else
		sys_gfx="AMD"	
fi
