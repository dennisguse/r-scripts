# 
# Renders a map of Germany with all German cities as points and in addition Berlin in detail.
# Rendering is done via ggplot2 as well as interactive via plotly.
#
# Dennis Guse, dennis.guse@alumni.tu-berlin.de
#

if(!"rgdal" %in% installed.packages()) install.packages("rgdal")
library(rgdal)

if(!"mapdata" %in% installed.packages()) install.packages("mapdata")
library(mapdata)

if(!"ggplot2" %in% installed.packages()) install.packages("ggplot2")
library(ggplot2)

filename_points = "data/simplemaps-worldcities-basic.csv"

#LOAD: points from a CSV (without a projection)
points <- read.csv(filename_points, header = TRUE)
points = points[points$country == "Germany", ]

#LOAD: maps
mapGermany = map_data('worldHires', 'Germany')
mapBerlin = readOGR("data/berlin_bezirke.geojson")

#PLOT using ggplot2
p <- ggplot(points, aes(lng, y=lat))
p <- p + theme_bw()
p <- p + coord_fixed(1.3)
p <- p + geom_polygon(data = mapGermany, aes(x = long, y = lat, colour='gray', group=group, alpha=0.5), show.legend=FALSE)
p <- p + geom_polygon(data = mapBerlin, aes(x = long, y = lat, colour='gray', group=group, alpha=0.9), show.legend=FALSE)
p <- p + geom_point()
p <- p + geom_text(label = points$city)
p <- p + guides(shape = guide_legend(override.aes = list(size = 5)))

print(p)
  
#PLOT: make plot interactive using plotly
if (FALSE) {
  if(!"plotly" %in% installed.packages()) install.packages("plotly")
  library(plotly)
  
  ggplotly(p)
}
