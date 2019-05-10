# Once you have built the docker image and got it running you can use this R script to test it

rm(list = ls())

# You might need to install these packages first
library(jsonlite)
library(RCurl)

## First we need to build the URL to identify which data we want

# This is the Docker image we are running DataQC on
BaseURL <- "http://127.0.0.1:8001/GetLengthWeightPlot?"

# This is the Docker image we are running DataMapper on
DataMapperBaseURL <- "http://127.0.0.1:8000/GetBioData?"

# This is our JSON connection object - I wrote this manually but the idea is to write a helper application that coudl do it for you
# (note that the driver name you specify must actually exist on the server you are asking for data from - 
# SQL Server driver on Docker image is "ODBC Driver 17 for SQL Server")

# Example values
Driver <- "ODBC Driver 17 for SQL Server"
Server <- "YourServerName"
Database <- "YourDatabaseName"
User <- "YourUserName"
Password <- "YourPassword"
Query <- "Your_table_or_query"
Fields <- '[{"source": "databaseSampleID","destination": "SampleID"},{"source": "databaseLength","destination": "Length"},{"source": "databaseSex","destination": "Sex"},{"source": "databaseWeight","destination": "Weight"},{"source": "databaseMaturity","destination": "Maturity"},{"source": "databaseAge","destination": "Age"},{"source": "databaseName","destination": "SurveyName"},{"source": "databaseYear","destination": "SurveyYear"},{"source": "databaseMonth","destination": "SurveyMonth"},{"source": "databaseHaul","destination": "HaulNumber"},{"source": "databaseSampleIDSpecies","destination": "Species"}]'

# load in my real values - not included in GitHub repo...
source("MyConfig.R")

# Build the config object
MyConfigObject <- sprintf('{"connection": "Driver=%s; Server=%s; Database=%s; Uid=%s; Pwd=%s","table":"%s",  "fields": %s }', Driver, Server, Database,User,Password,Query,Fields)

# Build the URL

# (we need to URLencode the config object before we add it into the URL)
myURL <- paste(BaseURL,"ConfigObject=",URLencode(MyConfigObject, reserved=TRUE), sep="")

# These are the parameters we can pass in to the GetBioData at the moment
#MySurveyYear <- NA
MySurveyName <- 'IGFS2017'
#MyNumberOfRows <- 1000
MySpecies <- 'COD'

# Check whether the parameters need to be added to the URL (i.e. they are not NA) - add them to the URL if required
if(!is.na(DataMapperBaseURL)){
  myURL <- paste(myURL,"&BaseURL=",URLencode(DataMapperBaseURL, reserved=TRUE), sep="")
}
#if(!is.na(MySurveyYear)){
#  myURL <- paste(myURL,"&SurveyYear=",MySurveyYear, sep="")
#}
if(!is.na(MySurveyName)){
  myURL <- paste(myURL,"&SurveyName=",MySurveyName, sep="")
}
if(!is.na(MySpecies)){
  myURL <- paste(myURL,"&Species=",MySpecies, sep="")
}
#if(!is.na(MyNumberOfRows)){
#  myURL <- paste(myURL,"&NumberOfRows=",MyNumberOfRows, sep="")
#}


## Now try and get the data!

# We download the image and save it, then show it in R - there's probably a better way to do this...

download.file(myURL,'LengthWeightPlot.png',mode='wb')

library("png")
pp <- readPNG("LengthWeightPlot.png")
plot.new() 
rasterImage(pp,0,0,1,1)


