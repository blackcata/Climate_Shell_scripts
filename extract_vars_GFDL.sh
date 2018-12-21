#!/bin/bash

#------------------------------------------------------------------------------------#
#					 				             #      
#	      SCRIPT FOR EXTRACTING & REGRIDDING & CHOOSING VARIABLES		     #
#								   BY   : KMN        #
#				 				   DATE : 2018.12.20 #      
#								                     #      
#------------------------------------------------------------------------------------#

#
# Set specific varibles, years, file type
# 	1. Just change the upper setting part only and don't change below codes
# 	2. Basically, input.nml.org file has to exist on the same folder 
#   3. File type has to be fit with variables, it is included in one of five categories
#		ex) fed   ->   ocean_topaz_month
#			sst   ->   ocean_month
#			wind  ->   atmos_month
#			CN    ->   ice_month
#			water ->   land_month
#  4. You can change the regrid grid with changing regrid_type
#  5. Before running this script, regrid.x excutable file has to be set on the same folder
#

export regrid_type="regrid_spec_ocean1x1.nc"
export file_type="ocean_month.nc"   # The simulation result including variables
export var=("mld")             # Variable names 
export yr_strt=1941                  # Start year of regrdding
export yr_end=1941                   # End year of regridding

export date="0101"					# Month & Day of simulation results
export exp="chlon_SST_restore_E1"	# The name of simulation
export model="CM2.1"					# The name of model

export num_var=${#var[@]}    	    # the number of variables

# Initialize the log file
if [ -e log.out ] ; then 
	rm -f log.out 
fi
touch log.out

let "num_var -= 1"
for ivar in $(seq 0 $num_var); do
	export regrid_file=${var[$ivar]}"."$yr_strt"-"$yr_end"yr."$exp"."$model".nc"


	if [ -e  $regrid_file ]; then
		echo ""
		echo "#################  SYSTEM ALRET  ################"
		echo "#    REGRID FILE EXISTS, CHECK ONE MORE TIME    #"
		echo "#################################################"
		echo ""
	else
		echo ""
		echo "#################  SYSTEM ALRET  ################"
		echo "            STARTING REGRIDDING "${var[$ivar]}"             "
		echo "#################################################"
		echo ""
		echo "Regid file name : " $regrid_file
		echo "Start   Year : "  $yr_strt
		echo "End     Year : "  $yr_end
		echo ""

		# Regridding Process	
		for yr in $(seq -f "%04g" $yr_strt $yr_end); do 
			echo "Present Year  : "  $yr

			# Regridding - change input.nml
			export input_file_name=$yr$date"."$file_type
			export output_file_name=$yr"."${var[$ivar]}".nc"
			export var_name=${var[$ivar]}

			export line_change_0="s/grid_style/"$regrid_type"/"
			export line_change_1="s/inputfile/"$input_file_name"/"
			export line_change_2="s/outputfile/"$output_file_name"/"
			export line_change_3="s/var/"$var_name"/"

			echo "variable name : " $var_name
			echo "input file    : " $input_file_name
			echo "output file   : " $output_file_name

			sed -e $line_change_0 -e $line_change_1 -e $line_change_2 -e $line_change_3 < input.nml.org > input.nml


			# Regridding - excute regrid
			#./regrid.x >> log.out
			./regrid.x
			echo ""

		done 

		# Combine the regridded files
		export file_name="????."${var[$ivar]}".nc"
		ncrcat -h -O $file_name $regrid_file
		rm -f $file_name

	fi
done
