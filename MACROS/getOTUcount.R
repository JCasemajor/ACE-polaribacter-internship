## DESCRIPTION -----------------------------------------------------------------
# Name: getOTUcount.R
# Type : Function
# Description : count number of OTU of choice in set of dataframes
# Input : List of dataframes
# Output : List of dataframes
# Author : Juliette Casemajor
# Date : 28.03.2022
# R version : 4.1.2

## PROGRAM ---------------------------------------------------------------------

getOTUcount <- function(DATA,OTUlevel){
  for (i in 1:length(DATA)){
    DATA[[i]] <- DATA[[i]] %>% dplyr::count(get(OTUlevel))
    colnames(DATA[[i]]) <- c(OTUlevel,"n")
  }
  return(DATA)
}

## END -------------------------------------------------------------------------
