#!/bin/bash
#------------------------------------------------------------------------------------#
#					 				             #      
#	                    SCRIPT FOR REGRIDDING VARIABLES		             #
#								   BY   : KMN        #
#				 				   DATE : 2018.12.20 #      
#								                     #      
#------------------------------------------------------------------------------------#

export N_lat=360 	   # The number of latitude direction mesh
export N_lon=180 	   # The numer of longitude direction mesh 

export regrid="remapbil"   # Regridding method - bilinear
export var="po4"           # The name of variable to regrid

echo "Remapping variable : "$var
echo "Remapping lat/lon : "$N_lat"x"$N_lon
echo "Remapping Method : "$regrid
echo " "

export path_input="/data6/CMIP6/historical/monthly/po4/org"
export path_output="/data6/CMIP6/historical/monthly/po4/regrid"
export list=$(ls ${path_input})

# Start regrid process 
for input in $list; do
	# Set input & output files for regridding
	export file_input=$path_input"/"$input
	export file_output=$path_output"/regrid_"$N_lat"x"$N_lon"_"$input

	echo ""
    echo "!-----------------------------------------------------------------------!"
	echo "INPUT : "$file_input
	echo "OUTPUT : "$file_output
	echo ""

	# Excute the regridding by using CDO commands
    cdo $regrid,r$N_lat"x"$N_lon -selname,$var $file_input $file_output

	echo "REMAPPING COMPLETED "
	echo "!-----------------------------------------------------------------------!"
	echo ""
done
