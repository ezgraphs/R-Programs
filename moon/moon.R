
library(threejs)
moon_data <- read.csv("moon.csv", stringsAsFactors=FALSE)
moon <- system.file("images/moon.jpg", package="threejs")
globejs(img=moon, bodycolor="#555555", emissive="#444444", 
        lightcolor="#555555", lat=moon_data$Latitude.N, 
        long=moon_data$Longitude.E)

