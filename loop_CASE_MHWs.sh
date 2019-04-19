#!/bin/bash

#------------------------------------------------------------------------------------#
#                                                                                    #
#                 SCRIPT for loop for specific cases to each ncl file                #
#                                                                                    #
#                                                                BY   :  KM.Noh      #
#                                                                DATE : 2019.04.19   #
#                                                                                    #
#------------------------------------------------------------------------------------#

# Specific cases are designed with specific lat, lon range
export case_str=0   # First case of MHWs 
export case_end=9   # Last  case of MHWs

# Loop for each cases ncl file
for case in $(seq $case_str $case_end); do 
    export file_name="Scat_MHWs_index_MLD_SST.ncl"
    export line_change="s/region_case/"$case"/"
    
    # Change the case and make temporal file
    sed $line_change $file_name > tmp_$file_name 

    #Excute ncl file and remove file
    ncl tmp_$file_name
    rm tmp_$file_name
done
