googleSuggest = function(str='')
{
  library(XML)
  str=gsub(' ','%20',str) # URL - escape spaces
  u=paste('http://google.com/complete/search?output=toolbar&q=',str, sep='')
  doc = xmlTreeParse(u, useInternal=TRUE)

  search_string=sapply(getNodeSet(doc, "//CompleteSuggestion/suggestion"), function(el){xmlGetAttr(el,"data")})
  count=sapply(getNodeSet(doc, "//CompleteSuggestion/num_queries"), function(el){xmlGetAttr(el,"int")})
  df=as.data.frame(cbind(search_string,count))

  # My numbers behave strangely.  So I do this conversion... Why???
  df$count=as.numeric(as.character(df$count))
  df
}

# This function iterating through to get each letter of the alphabet... 
# for example
#   http://google.com/complete/search?output=toolbar&q=how%20can%20i%a
#   http://google.com/complete/search?output=toolbar&q=how%20can%20i%b
#   ...
#
# I especially like the concise syntax for iterating through the letters of the alphabet
# http://stackoverflow.com/questions/1439513/creating-a-sequential-list-of-letters-with-r
#

googleSuggestAll = function(str='')
{
  queries = paste(str,letters)
  df=data.frame()
  for (i in 1:length(queries)) {
    df=rbind(df,googleSuggest(queries[i]) )
  }
  df=df[with(df, order(df$count, decreasing=TRUE)),]
  df
}