# Code for blog post: http://www.r-chart.com/2016/10/map-of-middle-earth-map-above-was.html
library(ggplot2)
library(ggmap)
library(maptools)

# Clone the https://github.com/jvangeld/ME-GIS repo.  Set the working directory to this path.
# This repo contains Middle Earth shapefiles.

setwd('/path/to/downloaded/ME-GIS/')

coastline <- readShapeSpatial('Coastline2.shp')
forests <- readShapeSpatial('Forests.shp')
lakes <- readShapeSpatial('Lakes2.shp')
rivers <- readShapeSpatial('Rivers19.shp')
contours <- readShapeSpatial('Contours_18.shp')

# Each layer is rendered progressively as a polygon or path.
ggplot() +
 geom_polygon(data = fortify(contours), 
              aes(x = long, y = lat, group = group),
              color = '#f0f0f0', fill='#f0f0f0', size = .2) +
 geom_path(data = fortify(coastline), 
           aes(x = long, y = lat, group = group),
           color = 'black', size = .2) +
 geom_polygon(data = fortify(forests), 
          aes(x = long, y = lat, group = group),
          color = '#31a354', fill='#31a354', size = .2) +
 geom_polygon(data = fortify(lakes), 
            aes(x = long, y = lat, group = group),
            color = '#a6bddb', fill='#a6bddb', size = .2) +
 geom_path(data = fortify(rivers), 
            aes(x = long, y = lat, group = group),
            color = '#a6bddb', size = .2) + 
 ggtitle('Middle Earth') + 
 ylab('') + 
 xlab('Shapefiles: https://github.com/jvangeld/ME-GIS')
