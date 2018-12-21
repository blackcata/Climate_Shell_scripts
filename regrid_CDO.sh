#!/bin/bash
#------------------------------------------------------------------------------------#
#					 				             #      
#	                    SCRIPT FOR REGRIDDING VARIABLES		             #
#								   BY   : KMN        #
#				 				   DATE : 2018.12.20 #      
#								                     #      
#------------------------------------------------------------------------------------#

export N_lat=180 	   # The number of latitude direction mesh
export N_lon=360 	   # The numer of longitude direction mesh 

export regrid="remapbil"   # Regridding method - bilinear
export var="MLD"           # The name of variable to regrid

echo "Remapping variable : "$var
echo "Remapping lat/lon : "$N_lat"x"$N_lon
echo "Remapping Method : "$regrid

export yrstrt="1980"       # Starting year of regridding
export yrend="2015"	   # End year of regridding

# Start regrid process 
for ((yr=$yrstrt; $yr <= $yrend; yr++)); do
	# Set input & output files for regridding
	export file_input="MLD_SODA_"$yr".nc"
	export file_output="MLD_SODA_$yr."$regrid"."$N_lon"x"$N_lat".nc"

	echo ""
	echo "INPUT : "$file_input
	echo "OUTPUT : "$file_output
	echo ""

	# Excute the regridding by using CDO commands
	cdo $regrid,r$N_lat"x"$N_lon -selname,$var $file_input $file_output

	echo "REMAPPING COMPLETED "
	echo ""
done 
