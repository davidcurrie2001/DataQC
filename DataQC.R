# DataQC.R

#' Get biological data using the ConfigObject supplied
#' @param  BaseURL The URL of the DataMapper /GetBioData function
#' @param  ConfigObject The JSON configuration object that defines how to connect to the database
#' @param  SurveyName The name of the survey to return, the default value is to return all surveys
#' @param  Species The three letter code of the species data to return, the default value is to return all species
#' @get /GetLengthWeightPlot
#' @png
GetLengthWeightPlot <- function(BaseURL, ConfigObject, SurveyName, Species){
  
  if (!require(DaveQCTest)){
    install.packages('/usr/DaveQCTest_0.1.0.tar.gz', repos = NULL)
    if (!require(DaveQCTest)){
      return("Error- could not install DaveQCTest")
    }
  }
  
  LengthWeightPlot(BaseURL=BaseURL, ConfigObject = ConfigObject, SurveyName = SurveyName, Species = Species)
  
}
