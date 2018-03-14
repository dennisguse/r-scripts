# 
# Select all spatial geometries contained withon other spatial geometries (here: points and shapes).
# Exports the result as CSV and GeoJSON.
#
# Dennis Guse, dennis.guse@alumni.tu-berlin.de
#

if(!"rgdal" %in% installed.packages()) install.packages("rgdal")
library(rgdal)

filename_points = "data/simplemaps-worldcities-basic.csv"

#LOAD: points from a CSV (without a projection)
points <- read.csv(filename_points, header = TRUE)
points = points[points$country == "Germany", ]

#LOAD: shapes
shapes = readOGR("data/berlin_bezirke.geojson")

#Assume that the points use the same projection as the shapes.
#This step converts the points to a spatial object. 
coordinates(points) <- ~ lng + lat #Determined by the incoming data
proj4string(points) <- proj4string(shapes)

#####Select points within shape
data_withinShapes = over(points, shapes)

#Add shape data to points
#NOTE: data_points contains NA in all rows that are _not_ within a shape
data_points = cbind(points@data, data_withinShapes)

#EXPORT: data of points with matched shape data as CSV
write.csv(data_points, file=paste0("output/", basename(filename_points), "_points_WITHIN", ".csv"))

#EXPORT: points as GeoJSON with matched shape data
points@data = data_points
writeOGR(points, paste0("output/", basename(filename_points), "_POINTS", ".geojson"), layer="points", driver = "GeoJSON")


#####Select shapes with points
data_withinPoints = over(shapes, points)

#EXPORT: data of shapes as CSV (only containing data of shapes with points)
write.csv(data_withinPoints, file=paste0("output/", basename(filename_points), "_shapes_WITHIN", ".csv"))

#EXPORT: shapes that contain a point as GeoJSON
shapes@data = data_withinPoints
writeOGR(shapes, paste0("output/", basename(filename_points), "_SHAPES", ".geojson"), layer="shapes", driver = "GeoJSON")