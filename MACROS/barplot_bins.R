## DESCRIPTION -----------------------------------------------------------------
# Name: barplot_bins.R
# Type : Function
# Description : plot the barplot for the number of OTU SCG in each bin
# Input : Dataframe
# Output : Barplot
# Author : Juliette Casemajor
# Date : 24.03.2022
# R version : 4.1.2

## PROGRAM ---------------------------------------------------------------------

barplot_bins <- function(palette, DATA, title){
  bp <- ggplot(DATA, aes(x=name_bin, y=n))+
    geom_bar(stat="identity",width=0.5, fill= "#4aa0d3")+
    ggtitle(title)+
    #scale_fill_manual(values = palette)+
    ylab("Nombre de SCCG")+
    xlab("\nBins")+
    #labs(fill = "Nom des bins", cex.names = 3)+
    expand_limits(y=c(0,60))+
    theme(axis.text.x = element_text(angle = 90, size = 14, face = "bold"),
          axis.text.y = element_text(size = 14, face = "bold"),
          plot.title = element_text(color = "black", size = 17, face = "bold"))
  return(bp)
}

## END -------------------------------------------------------------------------