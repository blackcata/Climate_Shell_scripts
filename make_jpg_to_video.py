#------------------------------------------------------------------------------------#
#                                                                                    #
#                 SCRIPT for making contours and combining to one Video              #
#                                                                                    #
#                                                          BY : KYUNG MIN NOH        #
#                                                          DATE : 2022.08.01         #
#                                                          Based On below Code       #
#                                                           : https://bit.ly/3zKbRKO #
#------------------------------------------------------------------------------------#

import os,sys
import datetime
import imageio
import moviepy.editor as mp
import numpy as np
import matplotlib.pyplot as plt


def basemap_eck4( contour, axes, lat, lon, lon0 ):

    m = Basemap( projection = 'eck4', lon_0 = lon0, resolution = 'c' ,ax = axes)
    m.fillcontinents( color = 'grey', lake_color = 'grey', alpha = 0.3 )
    m.drawcoastlines( linewidth = 0.25)
    m.drawmapboundary( fill_color = 'white')

    contour_shifted, lon_shifted = shiftgrid( lon0 + lon[0] + 180, contour, lon + 1e-5, start = False )

    lon_new, lat_new = np.meshgrid( lon_shifted, lat )

    x, y = m( lon_new, lat_new )

    m.drawparallels( np.arange(-60.,61.,30.), labels = [1,0,0,0], color = 'grey' )
    m.drawmeridians( np.arange(-180.,181.,60.), labels = [0,0,0,1], color = 'grey' )

    return m, x, y, contour_shifted


def make_jpg_to_video(remove_tmp,filenames,output_name,frame_duration):

    # build gif
    with imageio.get_writer(output_gif, mode='I',duration=frame_duration) as writer:
    for filename in filenames:
        if os.path.exists(filename):
            image = imageio.imread(filename)
            writer.append_data(image)

    # convert to mp4
    clip = mp.VideoFileClip(output_gif)
    clip.write_videofile(output_mp4)

    # Remove temporary files
    if (remove_tmp):
        for filename in set(filenames):
            if os.path.exists(filename):
                os.remove(filename)            


##################################################################################
#                 Mannual Setting for Video of Variable Changes                  #
##################################################################################
## Inputdata Settings
dir_name  = "./DATA/"
file_name = "fCO2_CMIP6_CDRMIP_MM.nc"
path_name = dir_name+file_name
f         = xr.open_dataset(path_name)

## Colorbar Settings
colorbar_min      = 0   ; colorbar_max      = 2000
colorbar_levels   = 31  ; 
level_boundaries  = np.linspace(colorbar_min,colorbar_max,colorbar_levels+1)
cmap_type         = 'gist_heat_r'
cbar_font_size    = 10

## Variable Settings
ann_var    = f.fgco2
year_strt  = 1900 ; year_end = 2100
var_name   = "Anthropogenic CO2 Emission"
unit_name  =  "[gC/m$^2$/yr]"

## Ouputdata Image Settings
dir_name        =  "./RESULT/CO2_Ant/"
title_prefix    =  "Contour_CESM2_Ant_CO2_emission_surf_"
title_extension =  "jpeg"

## Output Video Settings
dir_name       =  "./RESULT/CO2_Ant/"
output_gif     =  dir_name+"Contour_CESM2_Ant_CO2_emission_surf_1900-2100.gif"
output_mp4     =  dir_name+"Contour_CESM2_Ant_CO2_emission_surf_1900-2100.mp4"
frame_duration = 0.1 #seconds per frame
##################################################################################
##################################################################################

lon0      = -0
filenames = []
for yr in range(year_strt,year_end+1):#
    if (yr%20 == 0): print("Year : {:4d}".format(yr))
    fig, axes = plt.subplots(1,1,figsize=(6,4.1),constrained_layout=True)    
    tmp = ann_var.where(ann_var.time.dt.year == yr).mean("time")

    m, x, y, contour = basemap_eck4( tmp, axes, 
    tmp.lat.values, 
    tmp.lon.values ,
    lon0)

    contour_var = m.pcolormesh(x,y,contour,cmap=cmap_type,vmin=vmin,vmax=vmax)
    axes.set_title(var_name + " [{:4d}]".format(yr))

    cb = fig.colorbar(contour_var,ax=axes, location='bottom',shrink=0.8)
    cb.set_ticks(np.linspace(vmin,vmax,5))
    cb.ax.tick_params(labelsize=cbar_font_size)
    cb.ax.set_xlabel(unit_name,fontsize=cbar_font_size)

    ## Save the output file
    title_name  =  title_prefix + str(yr) + "." + title_extension
    path_name   =  dir_name+title_name

    fig.savefig(path_name)
    plt.close()
    filenames.append(path_name) 

make_jpg_to_video(False,filenames,output_mp4,frame_duration)    
