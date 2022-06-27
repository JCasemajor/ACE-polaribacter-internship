---
title: "select-bacterial-genomes"
author: "Juliette Casemajor"
date: "2/25/2022"
language: bash
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Input

The input here is the txt file from "[anvi-display-contigs-stats](https://anvio.org/help/main/programs/anvi-display-contigs-stats/)" (Anvio v7.1) for each co-assemby group.

```{r}
input <- read.delim2("display_contigs_stats_coassemblies.txt")
head(input)
```

# Select the number of bacterial genomes

For further analysis, we will need to extract the number of bacterial genomes estimated by Anvi'o.

```{bash}
#!/bin/bash

awk 'BEGIN{FS=OFS=" "} NR==1{print} NR==30{for (i=3;i<=NF;i++) a[i]=$i} END{printf "genome_bact" OFS; for (i=1; i<=NF;i++) printf a[i] OFS; printf "\n"}' $* > genome-bact.txt
```

# Exected output
```{r}
output <- read.delim2("genome-bact.txt",sep="\t")
head(output)
```


