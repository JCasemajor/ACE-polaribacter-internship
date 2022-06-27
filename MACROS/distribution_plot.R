## DESCRIPTION -----------------------------------------------------------------
# Name: distribution_plot.R
# Type : Function
# Description : plot the taxonomic distribution of the SCG in each group of samples
# Input : Dataframe
# Output : stacked barplot
# Author : Juliette Casemajor
# Date : 28.03.2022
# R version : 4.1.2

## PROGRAM ---------------------------------------------------------------------

distribution_plot <- function(DATA,palette,title){
  bp <- ggplot(DATA, aes(x=group, y=distribution, fill=fct_reorder(OTUs,distribution)))+
    geom_bar(aes(),stat="identity",position="stack")+
    scale_fill_manual(values = palette)+
    labs(fill="OTUs")+
    ggtitle(title)+
    theme(legend.position="right")+guides(fill=guide_legend(nrow=15))
  return(bp)
}


## END -------------------------------------------------------------------------