#------------------------------------------------------------------------------------#
#                                                                                    #
#      SCRIPT for loop for combining variables specific cases to each ncl file       #
#                                                                                    #
#                                                                BY   :  KM.Noh      #
#                                                                DATE : 2019.06.04   #
#                                                                                    #
#------------------------------------------------------------------------------------#

# Specific cases are designed with specific lat, lon range
export year_str=1982
export year_end=2017

export case_str=0   # First case of MHWs
export case_end=9   # Last  case of MHWs

# Loop for each cases ncl file
for case in $(seq $case_str $case_end); do
# Combine percentile 75/90 and climatologic mean
    export file_name_1=TS_CASE_${case}_75_percent.${year_str}-${year_end}.nc
    export file_name_2=TS_CASE_${case}_90_percent.${year_str}-${year_end}.nc
    export file_name_3=TS_CASE_${case}_clim.${year_str}-${year_end}.nc
    export output_clim=TS_CASE_${case}_clim_per.${year_str}-${year_end}.nc

    cdo merge $file_name_1 $file_name_2 $file_name_3 $output_clim

    # Combine MHWs properties : cumulative intensity, intensity, MHWs date, peak, start
    export file_name_1=TS_CASE_${case}_cum.${year_str}-${year_end}.nc
    export file_name_2=TS_CASE_${case}_intensity.${year_str}-${year_end}.nc
    export file_name_3=TS_CASE_${case}_MHWs_date.${year_str}-${year_end}.nc
    export file_name_4=TS_CASE_${case}_peak.${year_str}-${year_end}.nc
    export file_name_5=TS_CASE_${case}_start_day.${year_str}-${year_end}.nc
    export output_MHWs=TS_CASE_${case}_MHWs_index.${year_str}-${year_end}.nc
 
    cdo merge $file_name_1 $file_name_2 $file_name_3 $file_name_4 $file_name_5 $output_MHWs
    echo $case
done
