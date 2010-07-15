getDocNodeVal=function(doc, path)
{
   sapply(getNodeSet(doc, path), function(el) xmlValue(el))
}

gGeoCode=function(str)
{
  library(XML)
  u=paste('http://maps.google.com/maps/api/geocode/xml?sensor=false&address=',str)
  doc = xmlTreeParse(u, useInternal=TRUE)
  str=gsub(' ','%20',str)
  lng=getDocNodeVal(doc, "/GeocodeResponse/result/geometry/location/lat")
  lat=getDocNodeVal(doc, "/GeocodeResponse/result/geometry/location/lng")
  c(lat,lng)
}

bullseyeEtc=function(str)
{
  for (i in 1:10){points(loc[1],loc[2],col=heat.colors(10)[i],cex=i)}
  for (i in 1:10){points(loc[1],loc[2],col=heat.colors(10)[i],cex=i*.5)}
  title(main='The R User Conference 2010', sub='July 20-23, 2010')
  mtext("NIST: Gaithersburg, Maryland, USA")
  mtext("http://user2010.org",4)
}

loc=gGeoCode('100 Bureau Drive Gaithersburg, MD, 20899, USA')

# World
map('world', plot=TRUE, fill=TRUE);bullseyeEtc()

# USA
map('usa', plot=TRUE, fill=TRUE);bullseyeEtc()

# State
map('state','Maryland', plot=TRUE, fill=TRUE);bullseyeEtc()