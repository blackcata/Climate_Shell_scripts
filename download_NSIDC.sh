#!/bin/bash

 #------------------------------------------------------------------------------------#
 #                                                                                    #
 #                        SCRIPT for downloading the NSIDC DATA                       #
 #                                                                                    #
 #                                                                BY   :  KM.Noh      #
 #                                                                DATE : 2019.04.26   #
 #                                                                                    #
 #  P.S : Before you download the data, you have to configure the username and        #
 #        password for the earthdata site "https://urs.earthdata.nasa.gov"            #
 #                                                                                    #
 #  Instruction :                                                                     #
 #  echo "machine urs.earthdata.nasa.gov login <uid> password <password>" >> ~/.netrc #
 #  chmod 0600 ~/.netrc                                                               #
 #  Modifiy the ~/.netrc's <id>> and <password> to your Earthdat Login ID/PWD         #
 #                                                                                    #
 #------------------------------------------------------------------------------------#

export hemisphere="NH" # Hemisphere of the Earth
export yr_strt=1979    # Starting year of download data
export yr_end=2018     # End year of downlad data

if [ $hemisphere == "SH" ]; then
    # South Hemisphere
    export site_URL="https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0116_icemotion_vectors_v4/south/daily"
else
    # North Hemisphere
    export site_URL="https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0116_icemotion_vectors_v4/north/daily"
fi 

echo $site_URL

# Each input/output file's path and name

for yr in $(seq $yr_strt $yr_end); do
    if [ x$A == x$B ]; then
        # South Hemisphere
        export file_name="icemotion_daily_sh_25km_"$yr"0101_"$yr"1231_v4.1.nc"
    else
        # North Hemisphere
        export file_name="icemotion_daily_nh_25km_"$yr"0101_"$yr"1231_v4.1.nc"
    fi 

    export URL=$site_URL"/"$file_name
    echo $URL
    wget --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --keep-session-cookies --no-check-certificate --auth-no-challenge=on -r --reject "index.html*" -np -e robots=off $URL
done

