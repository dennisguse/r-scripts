# 
# Load geo data (example using Shapefile) and converts it into a CSV (all data and WKT).
# The data columns are named using the original names.
# The WKT columns is named WKT.
#
# Dennis Guse, dennis.guse@alumni.tu-berlin.de
#

if(!"rgdal" %in% installed.packages()) install.packages("rgdal")
library(rgdal)

if(!"rgeos" %in% installed.packages()) install.packages("rgeos")
library(rgeos)

filename_shapefile = "data/berlin_subway/subway_soldner.shp"

shapes = readOGR(filename_shapefile, encoding="utf8", use_iconv =  TRUE)

shapesWKT = c()
for(i in 1:length(shapes)) {
  shapesWKT[[i]] = writeWKT(shapes[i, ])
}

dataWKT = cbind(as.data.frame(shapes), WKT=shapesWKT, stringsAsFactors = FALSE)

write.csv(dataWKT, file=paste0("output/", "wkt.csv"), row.names = FALSE, fileEncoding="utf8")
