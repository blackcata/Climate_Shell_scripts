#!/bin/bash

export N_lat=360
export N_lon=180 

export regrid="remapbil"
export var="MLD"

echo "Remapping variable : "$var
echo "Remapping lat/lon : "$N_lat"x"$N_lon
echo "Remapping Method : "$regrid

export yrstrt="1980"
export yrend="2015"

for ((yr=$yrstrt; $yr <= $yrend; yr++)); do
	export file_input="MLD_SODA_"$yr".nc"
	export file_output="MLD_SODA_$yr."$regrid"."$N_lat"x"$N_lon".nc"

	echo ""
	echo "INPUT : "$file_input
	echo "OUTPUT : "$file_output
	echo ""

	cdo $regrid,r$N_lat"x"$N_lon -selname,$var $file_input $file_output

	echo "REMAPPING COMPLETED "
	echo ""
done 
