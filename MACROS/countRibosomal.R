## DESCRIPTION -----------------------------------------------------------------
# Name: countRibosomal.R
# Type : Function
# Description : count number of ribosomal genes set of dataframes
# Input : List of dataframes
# Output : List of dataframes
# Author : Juliette Casemajor
# Date : 01.04.2022
# R version : 4.1.2

## PROGRAM ---------------------------------------------------------------------

countRibosomal <- function(gene_column,DATA){
  for (i in 1:length(DATA)){
    DATA[[i]] <- DATA[[i]] %>% dplyr::count(get(gene_column))
    colnames(DATA[[i]]) <- c(gene_column,"n")
  }
  return(DATA)
}

## END -------------------------------------------------------------------------
