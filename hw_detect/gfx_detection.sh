
#!bin/bash
#detect graphics vendor of the system

if [ "$(lspci | grep VGA | grep -o AMD)" != "AMD" ]
	then
		if [ "$(lspci | grep VGA | grep -o NVIDIA)" != "NVIDIA" ]
			then 
				gfx=$(lspci | grep VGA | grep -o Intel)
			else
				gfx="NVIDIA"
		fi
	else
		gfx="AMD"	
fi
echo "$gfx"
