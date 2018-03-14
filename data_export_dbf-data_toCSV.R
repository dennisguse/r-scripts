# 
# Convert all files DBF files into CSV-files.
# Processes all *.dbf files in the current working directoring.
#
# Dennis Guse, dennis.guse@alumni.tu-berlin.de
#

if(!"foreign" %in% installed.packages()) install.packages("foreign")
library(foreign)

files = list.files(pattern="*.dbf")

lapply(files, function(fullPath) {
  print(fullPath)
  
  data = read.dbf(fullPath)
  
  write.csv2(data, paste0(fullPath, ".csv"))
  
  invisible(fullPath)
})
