
#!bin/bash
#detect graphics vendor of the system

gfx=$(lspci | grep VGA | grep -o AMD)
if [ "$gfx" != "AMD" ]
	then
		gfx=$(lspci | grep VGA | grep -o NVIDIA)
		if [ "$gfx" != "NVIDIA" ]
			then 
				gfx=$(lspci | grep VGA | grep -o Intel )
		fi
fi
