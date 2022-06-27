## DESCRIPTION -----------------------------------------------------------------
# Name: ribosomal_plot.R
# Type : Function
# Description : plot the ribosomal distribution of the SCG in each group of samples
# Input : Dataframe
# Output : stacked barplot
# Author : Juliette Casemajor
# Date : 28.03.2022
# R version : 4.1.2

## PROGRAM ---------------------------------------------------------------------

ribosomal_plot <- function(DATA,palette,title){
  bp <- ggplot(DATA, aes(x=name_bin, y=n, fill=fct_reorder(gene_name,n)))+
    geom_bar(stat="identity",width=0.5, position="stack")+
    ggtitle(title)+
    scale_fill_manual(values = palette)+
    ylab("Number of SCG")+
    labs(fill = "Gene name")+
    xlab("Name of the bin")+
    expand_limits(y=c(0,60))+
    theme(axis.text.x = element_text(angle=90,hjust=1,vjust=0.5))
  return(bp)
}
