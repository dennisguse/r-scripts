# 
# Split a Shapefile per spatial element (here: polygon) into seperate kml-files.
#
# Dennis Guse, dennis.guse@alumni.tu-berlin.de
#

if(!"rgdal" %in% installed.packages()) install.packages("rgdal")
library(rgdal)

filename_shapes = "data/berlin_bezirke.geojson"

shapes = readOGR(filename_shapes)

#SPLIT
#Option A: by index
shapes_split=split(shapes, 1:nrow(shapes), drop = TRUE)

#Option B: by each shapes data (i.e., feature 1); useful as a filename
shapes_split=split(shapes, shapes@data[, 1], drop = TRUE)

lapply(shapes_split, function(shape) {
  filename = paste0("output/", as.character(shape@data[1,1]), ".kml")
  writeOGR(shape, filename, layer=as.character(shape@data[1,1]), driver = "KML")
})
