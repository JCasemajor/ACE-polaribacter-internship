## DESCRIPTION -----------------------------------------------------------------
# Name: ribosomalAsDF.R
# Type : Function
# Description : converts the list of dataframes to a unique dataframe with 3 co-
#               lums : gene_name, name of the bin, number of SCG
# Input : List of dataframes
# Output : Dataframe
# Author : Juliette Casemajor
# Date : 11.04.2022
# R version : 4.1.2

## PROGRAM ---------------------------------------------------------------------

ribosomalAsDF <- function(DATA){
  dataframe <- data.frame()
  bins_names <- names(DATA)
  for (i in 1:length(DATA)){
    new_name <- unlist(strsplit(bins_names[i], split="_scg_taxonomy_details"))
    tmp <- unlist(strsplit(new_name,split="_"))
    if (nchar(tmp[2]) == 1){
      tmp[2] <- paste(tmp[1],"_00",tmp[2],sep="")
      bins_names[i] <- tmp[2]
    }
    else if (nchar(tmp[2]) == 2){
      tmp[2] <- paste(tmp[1],"_0",tmp[2],sep="")
      bins_names[i] <- tmp[2]
    }
    else {
      bins_names[i] <- new_name
    }
    if (length(DATA[[i]]$n) != 0){
      DATA[[i]]$name_bin <- bins_names[i]
      dataframe <- rbind(dataframe,DATA[[i]])
    }
  }
  dataframe <- dataframe[order(dataframe$name_bin),]
  rownames(dataframe) <- 1:nrow(dataframe)
  return(dataframe)
}

## END -------------------------------------------------------------------------

