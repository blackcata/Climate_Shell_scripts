#!/bin/csh -f

#------------------------------------------------------------------------------------#
#					 				             #      
#	      SCRIPT FOR EXTRACTING & REGRIDDING & CHOOSING VARIABLES		     #
#								   BY   : KM.NOH     #
#				 				   DATE : 2019.11.05 #      
#								                     #      
#------------------------------------------------------------------------------------#

#
# Set specific varibles, years, file type
# 	1. Just change the upper setting part only and don't change below codes
# 	2. Basically, input.nml.org file has to exist on the same folder 
#   3. Select the variables in the Atmosphere grid
#

set var = ("olr" "h500" "precip" "t_ref")

set yr_strt=1201
set yr_end=1300
set exp="chlon_Meltwater_SO_0.2"
set model="CM2.1"

set num_var=$#var
echo $num_var

set ivar=1
while( $ivar <= $num_var )

	set fn = atmos_month.nc
    set iyr=$yr_strt
    while( $iyr <= $yr_end )

        set file_input={$iyr}0101.atmos_month.nc
        set file_output={$var[$ivar]}{$iyr}.nc

        echo "Present Year  : "  $iyr
        echo "variable name : " $var[$ivar]
        echo "input file    : " $file_input
        echo "output file   : " $file_output
        echo ""

        ncks -O -v $var[$ivar]  $file_input $file_output
	    @ iyr++
	end

    ncrcat  -O {$var[$ivar]}????.nc {$var[$ivar]}.${yr_strt}-${yr_end}yr.$exp.$model.nc
    rm -f {$var[$ivar]}????.nc
@ ivar++
end
