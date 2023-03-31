#!/bin/bash
#------------------------------------------------------------------------------------#
#					 				             #      
#	                SCRIPT FOR VERTICAL REGRIDDING VARIABLES		             #
#								   BY   : KM.NOH     #
#				 				   DATE : 2020.11.19 #      
#								                     #      
#------------------------------------------------------------------------------------#

export N_lat=360 	   # The number of latitude direction mesh
export N_lon=180 	   # The numer of longitude direction mesh 

export depth="10,20,30,40,50,60,70,80,90,100,120,140,160,180,200,250,300,400,500,600,800,1000,1200,1400,1600,1800,2000,2250,2500,2750,3000,3500,4000,4500,5000"

export path_input="/home/km109/CMIP6/chl/historical/org"
export path_output="/home/km109/CMIP6/chl/historical/org"
export list=$(ls ${path_input})

# Start regrid process 
for input in $list; do
	# Set input & output files for regridding
	export file_input=$path_input"/"$input
	export file_output=$path_output"/3d_"$input

	echo ""
    echo "!-----------------------------------------------------------------------!"
	echo "INPUT : "$file_input
	echo "OUTPUT : "$file_output
	echo ""

	# Excute the vertically regridding by using CDO commands
    cdo intlevel,$depth $file_input $file_output

	echo "VERTICAL REMAPPING COMPLETED "
	echo "!-----------------------------------------------------------------------!"
	echo ""
done
