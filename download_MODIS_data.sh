#!/bin/bash
#------------------------------------------------------------------------------------#
#                                                                                    #
#                       SCRIPT for downloading the MODIS DATA                        #
#                                                                                    #
#                                                               BY   : KM.Noh        #
#                                                               DATE : 2019.08.23    #
#                                                                                    #
#------------------------------------------------------------------------------------#
#each input/output file's path and name

export list=$(cat 8d_daily_data_list.dat)

for data_url in $list; do
    wget --no-check-certificate $data_url
done
