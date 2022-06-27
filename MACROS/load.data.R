## DESCRIPTION -----------------------------------------------------------------
# Name: load.data.R
# Type : Function
# Description : loads a set of files in directory as a list of dataframes
# Input : Files in directory (.txt)
# Output : List of dataframes
# Author : Juliette Casemajor
# Date : 24.03.2022
# R version : 4.1.2

## PROGRAM ---------------------------------------------------------------------

load.data <- function(DIRECTORY){
  files_names <- list.files(here(DIRECTORY))
  nb_files <- length(files_names)
  OUTPUT <- lapply(paste(DIRECTORY,files_names,sep=""), read.delim2)
  for (i in 1:length(OUTPUT)){
    OUTPUT[[i]]$t_genus <- sapply(OUTPUT[[i]]$t_genus, as.character)
    OUTPUT[[i]]$t_genus[is.na(OUTPUT[[i]]$t_genus)] <- ""
    OUTPUT[[i]]$t_species <- sapply(OUTPUT[[i]]$t_species, as.character)
    OUTPUT[[i]]$t_species[is.na(OUTPUT[[i]]$t_species)] <- ""
    OUTPUT[[i]][OUTPUT[[i]] == ""] <- "No match"
  }
  names(OUTPUT) <- stringr::str_replace(files_names, pattern = ".txt", replacement = "")
  names(OUTPUT) <- gsub("-", "_", names(OUTPUT))
  return(OUTPUT)
}

## END -------------------------------------------------------------------------
