## DESCRIPTION -----------------------------------------------------------------
# Name: selectOTUlevel.R
# Type : Function
# Description : select rows containing OTU level of choice in set of dataframes
# Input : List of dataframes
# Output : List of dataframes
# Author : Juliette Casemajor
# Date : 24.03.2022
# R version : 4.1.2

## PROGRAM ---------------------------------------------------------------------

selectOTUlevel <- function(OTU,DATA,column){
  for (i in 1:length(DATA)){
    DATA[[i]] <- DATA[[i]] %>% filter(get(column) == OTU)
  }
  return(DATA)
}
## END -------------------------------------------------------------------------


