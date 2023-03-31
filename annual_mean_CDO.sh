#!/bin/bash
#------------------------------------------------------------------------------------#
#					 				             #      
#	                    SCRIPT FOR ANNUAL MEANING OF VARIABLES		        #
#								   BY   : KM.NOH      #
#				 				   DATE : 2022.11.17 #      
#								                     #      
#------------------------------------------------------------------------------------#

export path_input="/data1/CMIP6/SSP585/monthly/dissic/regrid/vert_regrid"
export path_output="/home/km109/Analysis/Python/Arctic_Carbon_Cycle/DATA/CMIP6_SSP585_DIC"
export list=$(ls ${path_input})

# Start convert monthly data to yearly data
for input in $list; do
#export input="3d_regrid_360x180_dissic_Omon_GFDL-ESM4_1pctCO2-cdr_r1i1p1f1_gr_014101-034012.nc"
    # Set input & output files for regridding
    export file_input=$path_input"/"$input
    export file_output=$path_output"/ann_"$input

    echo ""
    echo "!-----------------------------------------------------------------------!"
    echo "INPUT : "$file_input
    echo "OUTPUT : "$file_output
    echo ""

    # Excute the annual mean by using CDO commands
    cdo -yearmean $file_input $file_output

    echo "ANNUAL MEAN COMPLETED "
    echo "!-----------------------------------------------------------------------!"
    echo ""
done
