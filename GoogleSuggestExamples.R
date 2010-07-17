#
# Usage
#
df=googleSuggest('American Idol')

#
# Example: Limit results 
#
df[grep('results',df$search_string),]

#
# Plot
#
library(ggplot2)
qplot(df$search_string, df$count, stat='identity', geom='bar') + opts(axis.text.x=theme_text(angle=-90)) + coord_flip() +xlab('Suggestion String') +ylab('Number of Queries')


# The search that inspired the post at http://www.r-chart.com
df=googleSuggestAll('R')