#!/bin/bash

#------------------------------------------------------------------------------------#
#					 				             #      
#	      SCRIPT FOR UNZIPPING AND EXTRACTING FILES		     #
#								   BY   : KM.Noh     #
#				 				   DATE : 2024.01.21 #      
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

export var=("ocean_cobalt_btm.nc" "ocean_cobalt_fdet_100.nc" "ocean_cobalt_tracers_int.nc" 
            "ocean_cobalt_omip_2d.nc" "ocean_cobalt_omip_sfc.nc" "ocean_cobalt_omip_tracers_month_z.nc"
            "ocean_cobalt_sfc.nc" "ocean_cobalt_fluxes_int.nc" "ocean_month.nc")                   # Variable names 
export yr_strt=1990                  # Start year of regrdding
export yr_end=1992                  # End year of regridding

export date="0101"	             # Month & Day of simulation results
export exp="historical_D1_c5_dfe_fert_B10"    # The name of simulation

export model="ESM4"    # The name of simulation
export dir="/archive/Kyungmin.Noh/CMIP6/ESM4/DECK_IF/"
export input_path=$dir$model"_"$exp"/gfdl.ncrc5-intel22-prod-openmp/history/"
export output_path=$dir$model"_"$exp"/gfdl.ncrc5-intel22-prod-openmp/history/extracted_vars/"

echo "#################################################################"
echo "                        BASIC INFORMATIONS                       "
echo "#################################################################"
echo "Input PATH    : " $input_path
echo "Output PATH   : " $output_path
export num_var=${#var[@]}    	     # the number of variables
echo "Output Files  : " $num_var

# Initialize the log file
if [ ! -d $output_path ] ; then 
	mkdir $output_path 
fi

let "num_var -= 1"
for ivar in $(seq 0 $num_var); do

    echo ""
    echo "######################  SYSTEM ALRET  #####################"
    echo "      STARTING EXTRACTTING "${var[$ivar]}"             "
    echo "###########################################################"
    echo ""
    echo "Regid file name : " $regrid_file
    echo "Start   Year : "  $yr_strt
    echo "End     Year : "  $yr_end
    echo ""

    # Regridding Process	
    for yr in $(seq -f "%04g" $yr_strt $yr_end); do 
        echo "Present Year  : "  $yr

        # Extracting - change input.nml
        export input_file_name=$yr$date".nc"
        export var_name=${var[$ivar]}
        export output_file_name=$yr$date"."$var_name

        echo "input file    : " $input_file_name
        echo "input path    : " $input_path$input_file_name
        echo "output path   : " $output_path$output_file_name

        if [ -f  $output_file_name ]; then
            echo ""
            echo "#################  SYSTEM ALRET  ################"
            echo "        FILE EXISTS, CHECK ONE MORE TIME         "
            echo "#################################################"
            echo ""
            continue
        fi

        tar -xf $input_path$input_file_name".tar" -C "$output_path" --wildcards "*$var_name*"
        echo ""

    done
done
