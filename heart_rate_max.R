library(ggplot2)

df <- read.csv('heart_rate_max.csv', sep=';')
df2 <- melt(df, id="Age")

ggplot(data=df2, aes(x=Age, y=value, group=variable, color=variable)) + geom_line() + opts(title='Comparison of HR Max Calculation Methods')+scale_colour_discrete(name='Calculation') + scale_y_continuous('Beats per Minute')
ggsave('max_heart_rate_calculation_methods.png')

ggplot(data=df2, aes(x=Age, y=value)) + opts(title='Max Heart Rate (Smoothed)') + geom_smooth(aes(group=1))
ggsave('all_methods_smoothed.png')

ggplot(data=df2, aes(x=Age, y=value, group=variable, color=variable)) + geom_point() + opts(title='Max Heart Rate (Smoothed)') + geom_smooth(aes(group=1))
ggsave('all_methods_smoothed_points.png')

women <- df2[grep('women$', df2$variable),]
ggplot(data=women, aes(x=Age, y=value, group=variable, color=factor(variable))) + geom_line() + opts(title='Women')+scale_colour_discrete(name='Calculation') +scale_y_continuous('Beats per Minute')
ggsave('women_heart_rate_max.png')


# matrix <- t(df)
# colnames(matrix) <- matrix[1,]
# matrix <- matrix[-1,]
# df3=as.data.frame(matrix)
# df4=as.data.frame(mean(df3))
# men  <- df2[grep('_men', df2$variable),]
# both_men_and_women  <- c(grep('women$', df2$variable),grep('_men', df2$variable))
# both  <- df2[-both_men_and_women,]

# df4$Age <- rownames(df4)
# df4$variable <- 'Mean'
# colnames(df4) <- c('value','Age', 'variable')




