#!/bin/bash

#------------------------------------------------------------------------------------#
#																					 #
#				  SCRIPT for combining each netCDF files to one file				 #
#																					 #
#																	BY : KM109       #
#																  DATE : 2019.01.31  #
#																					 #
#------------------------------------------------------------------------------------#

export yr_strt=1982   # Starting year of combining
export yr_end=2014    # End year of combining

# Each input/output file's path and name
export path_input="/home/km109/Analysis/NCL/SCRIPT/DATA/OISST_daily"
export path_output="/home/km109/Analysis/NCL/SCRIPT/DATA"

# Output file's name
export filename_output="OISST_v2_sst.day.mean."$yr_strt"-"$yr_end".nc"

# Information of input/output file name
echo "INPUT FILEs : " $filename_input
export list=$(ls "${path_input}")

for input in $list; do
	echo $input
done

echo ""
echo "OUPUT FILEs : " $filename_output

# Merge the netcdf files and make one combined file
cdo mergetime $path_input"/"* $path_output"/"$filename_output
