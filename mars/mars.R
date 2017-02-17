library(threejs)

the_martian <- read.csv("the_martian.csv", comment.char="#")

# mariner-9-mars.jpg
# Mars_Viking_MDIM21_ClrMosaic_global_1024.jpg
# Mars_MGS_colorhillshade_mola_1024.jpg
# 20151105_mars_lander_map_f840.jpg
globejs(img="Mars_MGS_colorhillshade_mola_1024.jpg", bodycolor="#555555", emissive="#444444", 
        lightcolor="#555555", 
        lat=the_martian$x, 
        long=the_martian$y)