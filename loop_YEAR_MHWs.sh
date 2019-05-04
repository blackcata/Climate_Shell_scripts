#!/bin/bash

#------------------------------------------------------------------------------------#
#                                                                                    #
#                 SCRIPT for loop for MHWs definition by each year                   #
#                                                                                    #
#                                                                BY   :  KM.Noh      #
#                                                                DATE : 2019.05.02   #
#                                                                                    #
#------------------------------------------------------------------------------------#

# Specific cases are designed with specific lat, lon range
export yr_str=1982   # First case of MHWs 
export yr_end=2018   # Last  case of MHWs

# Loop for each cases ncl file
for year in $(seq $yr_str $yr_end); do 
    export file_name="MHW_main.loop.f90"
    export line_change="s/year_MHW/"$year"/"
    
    # Change the case and make temporal file
    sed $line_change $file_name > MHW_main.f90 

    #Excute excutable file and remove file
    make
    EXE_MHWs
    make clean
done
