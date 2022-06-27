## DESCRIPTION -----------------------------------------------------------------
# Name: buildDF.R
# Type : Function
# Description : build dataframe for all the SCG counts
# Input : Dataframe
# Output : Dataframe
# Author : Juliette Casemajor
# Date : 28.03.2022
# R version : 4.1.2

## PROGRAM ---------------------------------------------------------------------

buildDF <- function(DATA, allDATA,OTUlevel){
  dataframe <- data.frame()
  for (i in 1:length(DATA)){
    if (nrow(DATA[[i]]) != 0){
      dataframe <- bind_rows(dataframe,DATA[[i]])
    }
  }
  dataframe <- dataframe %>% group_by(get(OTUlevel)) %>% summarise_if(is.numeric,sum)
  dataframe <- as.data.frame(dataframe)
  colnames(dataframe) <- c(OTUlevel,"n")
  missing <- vector()
  for (i in allDATA[,1]){
    if (!(i %in% dataframe[,1])){
      missing <- c(missing,i)
    }
  }
  rows_num <- nrow(allDATA) - nrow(dataframe)
  for (i in 1:rows_num){
    new <- c(missing[i],0)
    dataframe <- rbind(dataframe,new)
  }
  dataframe$n <- as.integer(dataframe$n)
  return(dataframe)
}

## END -------------------------------------------------------------------------