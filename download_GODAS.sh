#!/bin/bash

#------------------------------------------------------------------------------------#
#																				     #
#					      SCRIPT for downloading the GODAS DATA  			         #
#																				     #
#																 BY   :  KM.Noh      #
#																 DATE : 2019.03.29   #
#										      										 #
#------------------------------------------------------------------------------------#

export yr_strt=1981   # Starting year of combining
export yr_end=1981    # End year of combining

export site_URL="https://cfs.ncep.noaa.gov/cfs/godas/pentad"

# Each input/output file's path and name

export list=$(cat month_day_index)

for yr in $(seq $yr_strt $yr_end); do 
	for mon_day_index in $list; do
		export file_name="godas.P."$yr$mon_day_index".grb"
		export URL=$site_URL"/"$yr"/"$file_name

		wget $URL
	done
done
