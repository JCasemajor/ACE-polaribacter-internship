## DESCRIPTION -----------------------------------------------------------------
# Name: getAllOTU.R
# Type : Function
# Description : get list of all OTU found in data
# Input : List of dataframes
# Output : Dataframe
# Author : Juliette Casemajor
# Date : 28.03.2022
# R version : 4.1.2

## PROGRAM ---------------------------------------------------------------------

getAllOTU <- function(DATA,level){
  dataframe <- data.frame()
  for (i in 1:length(DATA)){
    dataframe <- bind_rows(dataframe,as.data.frame(levels(c(as.factor(DATA[[i]][,1])))))
  }
  colnames(dataframe) <- level
  dataframe <- dataframe %>% distinct(get(level), .keep_all = FALSE)
  colnames(dataframe) <- level
  return(dataframe)
}

## END -------------------------------------------------------------------------


