# 
# Convert all _geo_ files to GeoJSON.
#
# Dennis Guse, dennis.guse@alumni.tu-berlin.de
#

if(!"foreign" %in% installed.packages()) install.packages("foreign")
library(foreign)

filePaths = list.files(pattern="*.shp|*.kml|*.TAB|*.gpx", recursive=TRUE)

lapply(filePaths, function(fullPath) {
  print(fullPath)
  
  data = readOGR(fullPath)
  
  writeOGR(data, paste0("output/", basename(fullPath), ".geojson"), layer=basename(fullPath), driver="GeoJSON")
  
  invisible(fullPath)
})
