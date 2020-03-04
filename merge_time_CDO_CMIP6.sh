#!/bin/bash
#------------------------------------------------------------------------------------#
#					 				             #      
#	                    SCRIPT FOR MERGING EACH TIME IN ONE VARAIBLE		             #
#								   BY   : KMN        #
#				 				   DATE : 2020.03.04 #      
#								                     #      
#------------------------------------------------------------------------------------#


export var="no3os_Omon"           # The name of variable to merge in CMIP6
export model="NorESM2-LM"         # The name of model to merge in CMIP6
export scenario="historical"      # The name of scenario to merge in CMIP6
export grid_style="gn"            # The name of grid_style to merge in CMIP6
export year_str="1850"            # The name of scenario start year to merge in CMIP6
export year_end="2014"            # The name of scenario end year to merge in CMIP6

export path_input="/data6/CMIP6/km109/historical/monthly/nitrate"
export path_output="/data6/CMIP6/km109/historical/monthly/nitrate"

export var_list=$(cat var_list_CMIP6.dat)
export model_list=$(cat model_list_CMIP6.dat)

# Start regrid process 
for var in $var_list; do
    for model in $model_list; do

        echo "Merging variable : "$var
        echo "Merging model : "$model
        echo "Merging scenario : "$scenario
        echo "Scenario range : "$year_str"-"$year_end

        export input_prefix=$var"_"$model"_"$scenario"_r1i1p1f1_"$grid_style
        # Set input & output files for regridding
        export file_input=$path_input"/"$input_prefix
        export file_output=$path_output"/"$input_prefix"_"$year_str"01-"$year_end"12.nc"

        echo ""
        echo "INPUT : "$file_input
        echo "OUTPUT : "$file_output
        echo ""

        # Excute the time merging by using CDO commands
        cdo mergetime $file_input"*" $file_output

        echo "MERGING COMPLETED "
        echo ""
    done
done
