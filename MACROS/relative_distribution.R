## DESCRIPTION -----------------------------------------------------------------
# Name: relative_distribution.R
# Type : Function
# Description : Compute distribution (in %) of SCG within each cluster of samples
# Input : Dataframe
# Output : Dataframe
# Author : Juliette Casemajor
# Date : 28.03.2022
# R version : 4.1.2

## PROGRAM ---------------------------------------------------------------------

relative_distribution <- function(dataframe){
  col = ncol(dataframe)
  for (i in 2:col){
    sumsample <- sum(dataframe[,i])
    rel_ab <- (dataframe[,i]/sumsample)*100
    dataframe[,i] <- rel_ab
  }
  return(dataframe)
}

## END -------------------------------------------------------------------------