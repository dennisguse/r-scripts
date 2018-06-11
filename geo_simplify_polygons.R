# 
# Load polygons and simplifies them.
# In this example polygons that fill a complete area are simplified without creating gaps.
#
# This demo also converts to EPSG4326.
#
# Dennis Guse, dennis.guse@alumni.tu-berlin.de
#
# NOTE: To install rmapshaper on Debian the following package must be installed: sudo apt install libssl-dev libjq-dev libprotobuf-dev protobuf-compile

if(!"rgdal" %in% installed.packages()) install.packages("rgdal")
library(rgdal)

if(!"rmapshaper" %in% installed.packages()) install.packages("rmapshaper")
library(rmapshaper)

filename_shapefile = "data/berlin_bezirke.geojson"

shapes = readOGR(filename_shapefile, encoding="utf8", use_iconv =  TRUE)
shapes = spTransform(shapes, CRS("+init=epsg:4326"))

shapesReduced001 = ms_simplify(shapes, keep = 0.01, keep_shapes = TRUE)
writeOGR(shapesReduced001, paste0("output/", basename(filename_shapefile), "001.geojson"), layer=basename(filename_shapefile), driver="GeoJSON", overwrite_layer=TRUE)


shapesReduced005 = ms_simplify(shapes, keep = 0.05, keep_shapes = TRUE)
writeOGR(shapesReduced005, paste0("output/", basename(filename_shapefile), "005.geojson"), layer=basename(filename_shapefile), driver="GeoJSON", overwrite_layer=TRUE)


shapesReduced010 = ms_simplify(shapes, keep = 0.10, keep_shapes = TRUE)
writeOGR(shapesReduced010, paste0("output/", basename(filename_shapefile), "010.geojson"), layer=basename(filename_shapefile), driver="GeoJSON", overwrite_layer=TRUE)

shapesReduced020 = ms_simplify(shapes, keep = 0.20, keep_shapes = TRUE)
writeOGR(shapesReduced020, paste0("output/", basename(filename_shapefile), "020.geojson"), layer=basename(filename_shapefile), driver="GeoJSON", overwrite_layer=TRUE)
