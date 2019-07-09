#!/bin/bash

#------------------------------------------------------------------------------------#
#                                                                                    #
#                         SCRIPT for downloading the OSCAR DATA                       #
#                                                                                    #
#                                                               BY   : KM.Noh        #
#                                                               DATE : 2019.07.09    #
#                                                                                    #
#------------------------------------------------------------------------------------#

export yr_strt=1993   # Starting year of combining
export yr_end=2019    # End year of combining


export id="blackcata"
export pwd="EpJ0X4o9atkJIhvoVkc"
export site_URL="https://podaac-tools.jpl.nasa.gov/drive/files/OceanCirculation/oscar/preview/L4/oscar_third_deg/"

# Each input/output file's path and name

export list=$(cat month_day_index)

for yr in $(seq $yr_strt $yr_end); do 
		export file_name="oscar_vel"$yr".nc.gz"
		export URL=$site_URL"/"$file_name

		wget --http-user=$id --http-password=$pwd $URL
done
