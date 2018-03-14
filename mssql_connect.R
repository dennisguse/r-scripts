# 
# Connect to a Microsoft SQLServer and load data.
#
# Dennis Guse, dennis.guse@alumni.tu-berlin.de
#

if(!"RODBC" %in% installed.packages()) install.packages("RODBC")
library(RODBC)

servername = "SERVER"

#Connect via Windows Authentication
dbconnection <- odbcDriverConnect(paste0("Driver={SQL Server};Server=", servername, ";trusted_connection=yes"))

#Connect via SQLUser
username="veryImportant"
password="verySecret"
dbconnection <- odbcDriverConnect(paste0("driver={SQL Server};server=", servername, ";Uid=", username, ";Pwd=", password, ";"))

data <- sqlQuery(dbconnection, 
"
SELECT * 
FROM VeryCoolTable
")
