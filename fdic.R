# http://www.fdic.gov/bank/statistical/stats/2010mar/fdic.xls
# File --> Save As .csv

df=read.csv('data/fdic.csv',header=TRUE, skip=4)
head(df)

# Remove Empty Columns
df=df[c(-2,-5,-7,-10,-12,-14,-16,-18,-20,-22,-24,-26,-28,-30,-32,-34,-36,-38,-40,-42)]

# Remove Rows with Trailing information
df=df[-(29:36),]

# fix the column names
colnames(df)=gsub('X','',colnames(df))
colnames(df)=gsub('X','',colnames(df))
colnames(df)[1]='Statistic'
colnames(df)[2]='2010' # But remember this is YTD

# I am kind of fuzzy about the rules - but it seems like you just have to try casting columns as factors in one
# context and as characters in another to get the desired result.  If there is a set rule about usage, please let
# me know.  At this point, I am accepting that these types are not handled in a consistent way and you just have
# to know how a particular function behaves.
#
df$Statistic=as.character(df$Statistic)

# Trim leading white space
df$Statistic=gsub('^ *','',df$Statistic)

# Remove Subheadings - include them inline
# Could do this by explicit naming
df$Statistic[11]='Problem Institutions Number'
df$Statistic[12]='Problem Institutions Assets'

# This is a bit more generic
df$Statistic[3]=paste(df$Statistic[2],df$Statistic[3])
df$Statistic[4]=paste(df$Statistic[2],df$Statistic[4])
df$Statistic[7]=paste(df$Statistic[6],df$Statistic[7])
df$Statistic[8]=paste(df$Statistic[6],df$Statistic[8])
df$Statistic[15]=paste(df$Statistic[14],df$Statistic[15])
df$Statistic[16]=paste(df$Statistic[14],df$Statistic[16])
df$Statistic[17]=paste(df$Statistic[14],df$Statistic[17])

# Remove Rows with no data (Empty Rows and Subheading Rows)
df=df[c(-1,-5,-9,-10,-13,-14,-18,-21,-24, -27),]

# At this point, we have the actual statistical data isolated.  
# However, it would easier use the data if it were pivotted.

# You can quickly pivot by transposing it - but the result is a matrix full of string data
t(df)

# Better to use the reshape package
library(reshape)
df.melted=melt(df, id="Statistic")

# Strip out all commas and cast the values to numerics.  Keep in mind, there are $ amounts and % for different stats
df.melted$value=as.numeric(gsub(',','',as.character(df.melted$value)))
colnames(df.melted)[2]='Year'
df.melted$Year=as.numeric(as.character(df.melted$Year))

# Pretty much done with the data set as a whole.  Now create subsets:
fdic_employees= df.melted[df$Statistic=='Number of FDIC Employees***',c('Year','value')]
fdic_employees$Year=factor(fdic_employees$Year)
fdic_employees$value=factor(fdic_employees$value)
colnames(fdic_employees)=c('Year','Number')

# Can break up into individual series
df$Statistic
pin=df.melted[df.melted$Statistic=="Problem Institutions Number",]
cb= df.melted[df.melted$Statistic=="Commercial Banks",]
si=df.melted[df.melted$Statistic=="Savings Institutions",]

# Another way to manipulate data frames is using sqldf
# The following compares several of the series with eachother.
library('sqldf')

pct_prob=sqldf('SELECT 
  p.Year Year, 
  p.value prob, c.value + s.value "Total Institutions", 
  p.value / (c.value + s.value) * 100 "Percent Problem"
FROM pin p 
JOIN cb c ON c.Year = p.Year 
JOIN si s ON s.Year = p.Year')

library(ggplot2)
p = qplot(data=pct_prob, Year, `Percent Problem`, color=`Total Institutions`, group=1) 
p = p + geom_line()
p + opts(axis.text.x=theme_text(angle=-90, hjust=0), title='Total FDIC Problem Institutions by Year')
ggsave('totalFDICProblemInstitutionsByYear.png')

fdicPlot=function(statistic){

  f=df.melted[df.melted$Statistic==statistic,]
  ggplot(data=f, aes(x=Year, y=value)) + geom_line() + geom_point() + opts(title=statistic) 
  img=paste(gsub(" |\\(|\\)|\\*",'',i),'.png',sep='')
  ggsave(img)

}

for (i in df$Statistic){fdicPlot(i)}
dev.off()