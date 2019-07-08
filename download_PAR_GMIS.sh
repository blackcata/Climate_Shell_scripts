#!/bin/bash

#------------------------------------------------------------------------------------#
#                                                                                    #
#                         SCRIPT for downloading the GMIS DATA                       #
#                                                                                    #
#                                                               BY   : KM.Noh        #
#                                                               DATE : 2019.07.08    #
#                                                                                    #
#------------------------------------------------------------------------------------#

export yr_strt=1998   # Starting year of combining
export yr_end=1998    # End year of combining

export site_URL="https://gmis.jrc.ec.europa.eu/satellite/9km"

# Each input/output file's path and name

export list=$(cat month_day_index)

for yr in $(seq $yr_strt $yr_end); do 
	for mon_day_index in $list; do
		export file_name="GMIS_S_PAR_"$mon_day_index"_"$yr".nc"
		export URL=$site_URL"/"$file_name

		wget $URL
	done
done
