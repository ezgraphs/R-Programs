# As of July 16th, 2010: http://www.energy.gov/open/oilspilldata.htm
# Combined Total Amount of Oil and Gas Recovered Daily 
# from the Top Hat and Choke Line oil recovery systems. 

library(ggplot2) 
df=read.csv('BP_Oil_Recovery.csv')

p = ggplot(data=df, aes(as.Date(df$End.Period), df$Recovery.Rate, color=Type)) + geom_line() 
p = p + facet_grid(Type ~ ., scales='free')+xlab('Date')+ylab('           Barrels of Oil                                      Million Cubic Feet of Gas')
p + opts(title='Deepwater Horizon Recovery Rate')
