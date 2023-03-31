#!/bin/bash
#------------------------------------------------------------------------------------#
#					 				             #      
#	                    SCRIPT FOR PUTING IN OR TAKING OUT EACH VARAIBLE		             #
#								   BY   : KM.NOH     
#
#				 				   DATE : 2020.03.26 #      
#								                     #      
#------------------------------------------------------------------------------------#

export path_input="/data6/CMIP6/SSP585/monthly"
export var_list=$(cat var_CMIP6.dat)
export mode="make"

for var in $var_list; do 
    # Make each variable folder
    if [ $mode = "make" ]; then
        mkdir $path_input"/"$var
        echo "FINISHED MAKING "${var}" FOLDERS"
    fi

    # Put all files to each folder
    if [ $mode = "take" ]; then
        export file_list=$(ls ${path_input}"/"${var})
        for file in $file_list; do
            mv $path_input"/"$var"/"$file $path_input
        done
        echo "FINISHED TAKING OUT "${var}
    fi

    # Take out all files from each folder
    if [ $mode = "put" ]; then
        export file_list=$(find $path_input -name $var"_*")
        for file in $file_list; do
            mv -f $file ${path_input}"/"${var}
        done
        echo "FINISHED PUTTING IN "${var}
    fi
done

