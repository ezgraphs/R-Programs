library(dplyr)
library(ggplot2)
library(scales)
library(reshape2)
library(tibble)

# Prepare data
df <- mtcars %>%
 rownames_to_column( var = "car" ) %>% # tibble
 mutate_each(funs(rescale), -car) %>% # scales
 melt(id.vars=c('car'), measure.vars=colnames(mtcars)) %>% 
 arrange(car)

# Line Plot
df %>% 
 filter(variable=='mpg') %>%
 ggplot(aes(x=car, y=value, group=1)) + 
 geom_line(color = 'purple')

# Line Plot with polar coordinates
df %>% 
 filter(variable=='mpg') %>%
 ggplot(aes(x=car, y=value, group=1)) + 
 geom_line(color = 'purple') +
coord_polar()

# Switch to geom_polygon to avoid gap.
df %>% 
 filter(variable=='mpg') %>%
 ggplot(aes(x=car, y=value, group=1)) + 
 geom_polygon(color = 'purple', fill=NA)

# Polar chart version 1
df %>% 
 filter(variable=='mpg') %>%
  ggplot(aes(x=car, y=value, group=1)) + 
  geom_polygon(color = 'purple', fill=NA) + 
 coord_polar() + theme_bw()

# Facet by variable
df %>%
 ggplot(aes(x=car, y=value, group=variable, color=variable)) + 
 geom_polygon(fill=NA) + 
 coord_polar() + theme_bw() + facet_wrap(~ variable) + 
 #scale_x_discrete(labels = abbreviate) + # Can increase the text size and uncomment
 theme(axis.text.x = element_text(size = 3))

# Facet by car
df %>%
 ggplot(aes(x=variable, y=value, group=car, color=car)) + 
 geom_polygon(fill=NA) + 
 coord_polar() + theme_bw() + facet_wrap(~ car) 
