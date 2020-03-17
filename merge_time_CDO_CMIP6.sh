#!/bin/bash
#------------------------------------------------------------------------------------#
#					 				             #      
#	                    SCRIPT FOR MERGING EACH TIME IN ONE VARAIBLE		             #
#								   BY   : KMN        #
#				 				   DATE : 2020.03.04 #      
#								                     #      
#------------------------------------------------------------------------------------#


export scenario="ssp585"      # The name of scenario to merge in CMIP6
export grid_style="gn"            # The name of grid_style to merge in CMIP6
export year_str="2015"            # The name of scenario start year to merge in CMIP6
export year_end="2100"            # The name of scenario end year to merge in CMIP6

export path_input="/data6/CMIP6/km109/rcp85/DATA"
export path_output="/data6/CMIP6/SSP585/monthly"

export var_list=$(cat var_list_CMIP6.dat)
export model_list=$(cat model_list_CMIP6.dat)
export file_list=$(cat /data6/CMIP6/km109/rcp85/log)


# Start regrid process 
for var in $var_list; do
    for model in $model_list; do

        echo "!-----------------------------------------------------------------------!"
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

        export num_model_files=$(ls ${path_input} | grep ${input_prefix} | wc -l)
        echo "Number of variable("$var") files in model("$model"): " $num_model_files

        if [ $num_model_files -eq 1 ]; then 
            # Copy the CMIP6 file, if there is only 1 file 
            cp $file_input"_"$year_str"01-"$year_end"12.nc" $file_output
        fi

        if [ $num_model_files -gt 1 ] ; then 
            if [ ${scenario} = "ssp126" ] || [ ${scenario} = "ssp245" ] || \
               [ ${scenario} = "ssp585" ]; then 
                # Exception for IPSL / MRI model, which extends to 2300 year in ScenarioMIP
                if [ ${model} = "IPSL-CM6A-LR" ] || [ ${model} = "MPI-ESM2-0" ]; then 
                    cp $file_input"_"$year_str"01-"$year_end"12.nc" $file_output
                else
                # Excute the time merging by using CDO commands
                    cdo mergetime $file_input"*" $file_output
                fi
            else
            # Excute the time merging by using CDO commands
                cdo mergetime $file_input"*" $file_output
            fi 
        fi

        echo "MERGING COMPLETED "
        echo "!-----------------------------------------------------------------------!"
        echo ""
    done
done
