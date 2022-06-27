## DESCRIPTION -----------------------------------------------------------------
# Name: selectOTU.R
# Type : Function
# Description : select rows containing OTU of choice in set of dataframes
# Input : List of dataframes
# Output : List of dataframes
# Author : Juliette Casemajor
# Date : 24.03.2022
# R version : 4.1.2

## PROGRAM ---------------------------------------------------------------------

selectOTU <- function(OTU,DATA){
  for (i in 1:length(DATA)){
    DATA[[i]] <- DATA[[i]][DATA[[i]]$t_genus == OTU,]
  }
  return(DATA)
}

## END -------------------------------------------------------------------------

