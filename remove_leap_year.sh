#!/bin/bash

#------------------------------------------------------------------------------------#
#																					 #
#				  SCRIPT for Removing the leap year to each file     				 #
#																					 #
#																	BY : KM.Noh      #
#																  DATE : 2019.02.18  #
#																					 #
#------------------------------------------------------------------------------------#

export yr_strt=1982   # Starting year of combining
export yr_end=2018    # End year of combining

# Each input/output file's path and name
export path_input="/home/km109/Analysis/NCL/SCRIPT/DATA/OISST_daily"
export path_output="/home/km109/Analysis/NCL/SCRIPT/DATA/OISST_daily/remove_leap"


export list=$(ls "${path_input}")

for input in $list; do
	export filename_input=$path_input"/"$input
	export filename_output=$path_output"/"$input

	# Information of input/output file name
	echo "INPUT FILEs : " $filename_input
	echo "OUPUT FILEs : " $filename_output
	echo ""

	# Delete the leap year from each file 
	cdo delete,month=2,day=29 $filename_input $filename_output
done

