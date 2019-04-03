#!/bin/bash

#------------------------------------------------------------------------------------#
#										     #
#    SCRIPT for transforming GODAS grib data to the NetCDF Format the GODAS DATA     #
#										     #
#								 BY   :  KM.Noh      #
#								 DATE : 2019.04.01   #
#			      							     #
#------------------------------------------------------------------------------------#

export yr_strt=1995   # Starting year of combining
export yr_end=1995    # End year of combining


# Each input/output file's path and name

export list=$(cat month_day_index)

for yr in $(seq $yr_strt $yr_end); do 
	for mon_day_index in $list; do
		export file_name="godas.P."$yr$mon_day_index".grb"
		ncl_convert2nc $file_name
	done
done
