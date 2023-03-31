#!/bin/bash
#------------------------------------------------------------------------------------#
#					 				             #      
#	                SCRIPT FOR ANNUAL MEANING OF VARIABLES IN SEASON	     #
#								   BY   : KM.NOH     #
#				 				   DATE : 2023.03.31 #      
#								                     #      
#------------------------------------------------------------------------------------#

export path_input="/data1/CMIP6/SSP585/monthly/dissic/regrid/vert_regrid"
export path_output="/home/km109/Analysis/Python/Arctic_Carbon_Cycle/DATA/CMIP6_SSP585_DIC"
export list=$(ls ${path_input})
export season_name="SON"

# Start convert monthly data to yearly data
for input in $list; do
#export input="ta_Amon_NorESM2-MM_historical_r1i1p1f1_gn_201001-201412.nc"
    # Set input & output files for regridding
    export file_input=$path_input"/"$input
    export file_output=$path_output"/ann_"$season_name"_"$input

    echo ""
    echo "!-----------------------------------------------------------------------!"
    echo "INPUT : "$file_input
    echo "OUTPUT : "$file_output
    echo ""

    # Excute the annual mean in specific season by using CDO commands
    cdo -seasmean -selseason,$season_name $file_input $file_output

    echo "ANNUAL MEAN ("$season_name") COMPLETED "
    echo "!-----------------------------------------------------------------------!"
    echo ""
done
