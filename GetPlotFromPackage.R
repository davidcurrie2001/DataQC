# This file uses the DaveQCTest package to generate a plot 
# The data is derived from the DataMapper docker image
#  It is useful to compare this output against that derived using the DataQC docker image

rm(list = ls())

# Manually install the test package if we need to ...
#install.packages('DaveQCTest_0.1.0.tar.gz', repos = NULL)

library('DaveQCTest')

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


# Call the LengthWeightPlot function from the DaveQCTest package
LengthWeightPlot(BaseURL=DataMapperBaseURL, ConfigObject = MyConfigObject, SurveyName = 'IGFS2016', Species = 'COD')

