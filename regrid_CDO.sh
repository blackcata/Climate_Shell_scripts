#!/bin/bash
#------------------------------------------------------------------------------------#
#					 				             #      
#	                    SCRIPT FOR REGRIDDING VARIABLES		             #
#								   BY   : KM.NOH     #
#				 				   DATE : 2018.12.20 #      
#								                     #      
#------------------------------------------------------------------------------------#

export N_lat=360 	   # The number of latitude direction mesh
export N_lon=180 	   # The numer of longitude direction mesh 

export regrid="remapbil"   # Regridding method - bilinear
export var="chlos"           # The name of variable to regrid

echo "Remapping variable : "$var
echo "Remapping lat/lon : "$N_lat"x"$N_lon
echo "Remapping Method : "$regrid
echo " "

export path_input="/home/Kyungmin.Noh/Python/DATA/"
export path_output="/home/Kyungmin.Noh/Python/DATA/"
export list=$(ls ${path_input})

# Start regrid process 
#for input in $list; do
export input="tmp.nc"
	# Set input & output files for regridding
	export file_input=$path_input"/"$input
	export file_output=$path_output"/regrid_"$N_lat"x"$N_lon"_"$input

	echo ""
    echo "!-----------------------------------------------------------------------!"
	echo "INPUT : "$file_input
	echo "OUTPUT : "$file_output
	echo ""

	# Excute the regridding by using CDO commands
    cdo -L $regrid,r$N_lat"x"$N_lon -selname,$var $file_input $file_output

	echo "REMAPPING COMPLETED "
	echo "!-----------------------------------------------------------------------!"
	echo ""
#done
