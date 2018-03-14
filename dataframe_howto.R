# 
# Working with data.frames
#
# Dennis Guse, dennis.guse@alumni.tu-berlin.de
#

###### Selecting items
dataset1 <- read.csv("data/dataset1.csv", header = TRUE)
dataset2 <- read.csv("data/dataset2.csv", header = TRUE)

#Mark subset
dataset1$select <- dataset1$key %in% dataset2$key

#Mark duplicates
dataset1$duplicated = duplicated(data.frame(dataset1$key))

##### Merging: inner join
merge(dataset1, dataset2, by="key")

##### Exclusion: left outer join
if(!"Hmisc" %in% installed.packages()) install.packages("Hmisc")
library(Hmisc)
dataset1[dataset1$key %nin% dataset2$key, ]
