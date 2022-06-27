05-SCG-taxonomic-distribution
================
Juliette Casemajor
6/27/2022

-   [Load packages and dependencies](#load-packages-and-dependencies)
    -   [Load packages](#load-packages)
    -   [Load functions files](#load-functions-files)
    -   [Load path for set of bins](#load-path-for-set-of-bins)
-   [Program](#program)
    -   [Load data](#load-data)
    -   [Phylum](#phylum)
        -   [Select OTU level](#select-otu-level)
        -   [Count OTU level](#count-otu-level)
    -   [Available OTUs](#available-otus)
    -   [Set up dataframe for
        distribution](#set-up-dataframe-for-distribution)
    -   [Compute the taxonomic distribution of SCG in each group of
        samples](#compute-the-taxonomic-distribution-of-scg-in-each-group-of-samples)
    -   [Bacteroidota](#bacteroidota)
        -   [Select OTU level](#select-otu-level-1)
        -   [Count OTU level](#count-otu-level-1)
        -   [Available OTUs](#available-otus-1)
        -   [Set up dataframe for
            distribution](#set-up-dataframe-for-distribution-1)
        -   [Compute the taxonomic distribution of SCG in each group of
            samples](#compute-the-taxonomic-distribution-of-scg-in-each-group-of-samples-1)
    -   [Flavobacteriaceae](#flavobacteriaceae)
        -   [Select OTU level](#select-otu-level-2)
        -   [Count OTU level](#count-otu-level-2)
        -   [Available OTUs](#available-otus-2)
        -   [Set up dataframe for
            distribution](#set-up-dataframe-for-distribution-2)
        -   [Compute the taxonomic distribution of SCG in each group of
            samples](#compute-the-taxonomic-distribution-of-scg-in-each-group-of-samples-2)
-   [Plot](#plot)
    -   [Phylum](#phylum-1)
        -   [Select colors](#select-colors)
        -   [Plot](#plot-1)
    -   [Bacteroidota](#bacteroidota-1)
        -   [Select colors](#select-colors-1)
        -   [Plot](#plot-2)
    -   [Flavobacteriaceae](#flavobacteriaceae-1)
        -   [Select colors](#select-colors-2)
        -   [Plot](#plot-3)
    -   [All](#all)
-   [End](#end)

# Load packages and dependencies

## Load packages

``` r
require(here)
require(stringr)
require(dplyr)
require(ggplot2)
require(cowplot)
require(tidyr)
require(forcats)
require(knitr)
```

## Load functions files

``` r
source("MacrosLoad.R")
```

## Load path for set of bins

In our case, in the DATA directory, our samples are clustered in 7
groups : s6_G1, s6_G2, s6_G3, s8_G7, s6_G6, s8_G4 and s8_G7. Each group
has a set of concoct bins. We have to recover this set of bins. In order
to do that, we have to define the path to each cluster.

``` r
s6G1_DIR <- paste("DATA","s6_G1/",sep="/")
s6G2_DIR <- paste("DATA","s6_G2/",sep="/")
s6G3_DIR <- paste("DATA","s6_G3/",sep="/")
s6G5_DIR <- paste("DATA","s6_G5/",sep="/")
s6G6_DIR <- paste("DATA","s6_G6/",sep="/")
s8G4_DIR <- paste("DATA","s8_G4/",sep="/")
s8G7_DIR <- paste("DATA","s8_G7/",sep="/")
```

# Program

## Load data

All the data will be load as a list of dataframes. There is a list for
each group of samples (7 lists of multiple dataframes).

``` r
s6_G1 <- load.data(s6G1_DIR) 
s6_G2 <- load.data(s6G2_DIR)
s6_G3 <- load.data(s6G3_DIR)
s6_G5 <- load.data(s6G5_DIR)
s6_G6 <- load.data(s6G6_DIR)
s8_G4 <- load.data(s8G4_DIR)
s8_G7 <- load.data(s8G7_DIR)
```

We want to see the taxonomic distribution of SCG in our samples. This
can be done at several levels. Here, we first want to see to which phyla
the SCGs are assigned. Then the SCG belonging only to the Bacteroidetes
and finally the SCG belonging to the Flavobacteriaceae.

## Phylum

### Select OTU level

For phylum, we don’t need to have special operations because we want to
keep them all. So we will keep all the elements that belong to the
domain of bacteria.

``` r
phylum_s6_G1 <- selectOTUlevel("Bacteria",s6_G1,"t_domain")
phylum_s6_G2 <- selectOTUlevel("Bacteria",s6_G2,"t_domain")
phylum_s6_G3 <- selectOTUlevel("Bacteria",s6_G3,"t_domain")
phylum_s6_G5 <- selectOTUlevel("Bacteria",s6_G5,"t_domain")
phylum_s6_G6 <- selectOTUlevel("Bacteria",s6_G6,"t_domain")
phylum_s8_G4 <- selectOTUlevel("Bacteria",s8_G4,"t_domain")
phylum_s8_G7 <- selectOTUlevel("Bacteria",s8_G7,"t_domain")
```

### Count OTU level

We want to count how many SCG are assigned to each phylum in our data.

``` r
count_s6_G1 <- getOTUcount(phylum_s6_G1,"t_phylum")
count_s6_G2 <- getOTUcount(phylum_s6_G2,"t_phylum")
count_s6_G3 <- getOTUcount(phylum_s6_G3,"t_phylum")
count_s6_G5 <- getOTUcount(phylum_s6_G5,"t_phylum")
count_s6_G6 <- getOTUcount(phylum_s6_G6,"t_phylum")
count_s8_G4 <- getOTUcount(phylum_s8_G4,"t_phylum")
count_s8_G7 <- getOTUcount(phylum_s8_G7,"t_phylum")
```

## Available OTUs

We want to see all the OTUs available in our data.

``` r
all_s6_G1 <- getAllOTU(count_s6_G1,"t_phylum")
all_s6_G2 <- getAllOTU(count_s6_G2,"t_phylum")
all_s6_G3 <- getAllOTU(count_s6_G3,"t_phylum")
all_s6_G5 <- getAllOTU(count_s6_G5,"t_phylum")
all_s6_G6 <- getAllOTU(count_s6_G6,"t_phylum")
all_s8_G4 <- getAllOTU(count_s8_G4,"t_phylum")
all_s8_G7 <- getAllOTU(count_s8_G7,"t_phylum")
all_OTUs <- bind_rows(all_s6_G1,all_s6_G2,all_s6_G3,all_s6_G5,all_s6_G6,all_s8_G4,all_s8_G7)
all_OTUs <- all_OTUs %>% distinct(t_phylum, .keep_all = FALSE)

rm(all_s6_G1,all_s6_G2,all_s6_G3,all_s6_G5,all_s6_G6,all_s8_G4,all_s8_G7)

kable(head(all_OTUs),caption = "Head of dataframe")
```

| t_phylum          |
|:------------------|
| Actinobacteriota  |
| Marinisomatota    |
| Proteobacteria    |
| Bacteroidota      |
| Cyanobacteria     |
| Verrucomicrobiota |

Head of dataframe

## Set up dataframe for distribution

Time to build the dataframe containing all the SCG counts in our data.

``` r
DF_s6_G1 <- buildDF(count_s6_G1,all_OTUs,"t_phylum")
DF_s6_G2 <- buildDF(count_s6_G2,all_OTUs,"t_phylum")
DF_s6_G3 <- buildDF(count_s6_G3,all_OTUs,"t_phylum")
DF_s6_G5 <- buildDF(count_s6_G5,all_OTUs,"t_phylum")
DF_s6_G6 <- buildDF(count_s6_G6,all_OTUs,"t_phylum")
DF_s8_G4 <- buildDF(count_s8_G4,all_OTUs,"t_phylum")
DF_s8_G7 <- buildDF(count_s8_G7,all_OTUs,"t_phylum")
```

Bind all the dataframes.

``` r
All_samples <- all_OTUs %>% left_join(DF_s6_G1, by="t_phylum") %>%
  left_join(DF_s6_G2, by="t_phylum") %>%
  left_join(DF_s6_G3,by="t_phylum") %>%
  left_join(DF_s6_G5,by="t_phylum") %>%
  left_join(DF_s6_G6,by="t_phylum") %>%
  left_join(DF_s8_G4,by="t_phylum") %>%
  left_join(DF_s8_G7,by="t_phylum")

names(All_samples)<-c("OTUs","s6_G1","s6_G2","s6_G3","s6_G5","s6_G6","s8_G4","s8_G7")

kable(head(All_samples),caption="Head of dataframe")
```

| OTUs              | s6_G1 | s6_G2 | s6_G3 | s6_G5 | s6_G6 | s8_G4 | s8_G7 |
|:------------------|------:|------:|------:|------:|------:|------:|------:|
| Actinobacteriota  |   203 |   300 |    29 |   505 |     0 |     8 |    84 |
| Marinisomatota    |    80 |   505 |     0 |   339 |     0 |     0 |    29 |
| Proteobacteria    | 13897 |  8662 |  1578 |  8315 |   333 |  1502 |  1539 |
| Bacteroidota      |  1916 |  1415 |   700 |  1490 |   316 |   758 |  1327 |
| Cyanobacteria     |    21 |     0 |     0 |    84 |     1 |     1 |    84 |
| Verrucomicrobiota |   214 |   341 |    13 |   544 |     0 |    52 |   253 |

Head of dataframe

## Compute the taxonomic distribution of SCG in each group of samples

``` r
distribution_phylum <- relative_distribution(All_samples)
kable(head(distribution_phylum),caption="Head of dataframe")
```

| OTUs              |      s6_G1 |     s6_G2 |      s6_G3 |      s6_G5 |      s6_G6 |      s8_G4 |      s8_G7 |
|:------------------|-----------:|----------:|-----------:|-----------:|-----------:|-----------:|-----------:|
| Actinobacteriota  |  1.2086931 |  2.280675 |  1.2356199 |  4.1383266 |  0.0000000 |  0.3297609 |  2.1949308 |
| Marinisomatota    |  0.4763322 |  3.839136 |  0.0000000 |  2.7780054 |  0.0000000 |  0.0000000 |  0.7577737 |
| Proteobacteria    | 82.7448645 | 65.850692 | 67.2347678 | 68.1389822 | 51.2307692 | 61.9126134 | 40.2142670 |
| Bacteroidota      | 11.4081572 | 10.757184 | 29.8253089 | 12.2101123 | 48.6153846 | 31.2448475 | 34.6746799 |
| Cyanobacteria     |  0.1250372 |  0.000000 |  0.0000000 |  0.6883553 |  0.1538462 |  0.0412201 |  2.1949308 |
| Verrucomicrobiota |  1.2741887 |  2.592367 |  0.5538986 |  4.4579202 |  0.0000000 |  2.1434460 |  6.6109224 |

Head of dataframe

``` r
distribution_phylum <- gather(distribution_phylum,group,distribution,s6_G1:s8_G7,factor_key=TRUE)
kable(head(distribution_phylum),caption="Head of dataframe")
```

| OTUs              | group | distribution |
|:------------------|:------|-------------:|
| Actinobacteriota  | s6_G1 |    1.2086931 |
| Marinisomatota    | s6_G1 |    0.4763322 |
| Proteobacteria    | s6_G1 |   82.7448645 |
| Bacteroidota      | s6_G1 |   11.4081572 |
| Cyanobacteria     | s6_G1 |    0.1250372 |
| Verrucomicrobiota | s6_G1 |    1.2741887 |

Head of dataframe

We delete the SCG attributed to OTUs that have a distribution of 0.

``` r
distribution_phylum <- distribution_phylum[substr(distribution_phylum$distribution,0.1,100) != 0,]
kable(head(distribution_phylum),caption="Head of dataframe")
```

| OTUs              | group | distribution |
|:------------------|:------|-------------:|
| Actinobacteriota  | s6_G1 |    1.2086931 |
| Marinisomatota    | s6_G1 |    0.4763322 |
| Proteobacteria    | s6_G1 |   82.7448645 |
| Bacteroidota      | s6_G1 |   11.4081572 |
| Cyanobacteria     | s6_G1 |    0.1250372 |
| Verrucomicrobiota | s6_G1 |    1.2741887 |

Head of dataframe

We are done with the phylum. We will now do the same with other
taxonomic levels.

## Bacteroidota

### Select OTU level

We want to select only the SCG belonging to the phylum Bacteroidota.

``` r
bacteroidota_s6_G1 <- selectOTUlevel("Bacteroidota",s6_G1,"t_phylum")
bacteroidota_s6_G2 <- selectOTUlevel("Bacteroidota",s6_G2,"t_phylum")
bacteroidota_s6_G3 <- selectOTUlevel("Bacteroidota",s6_G3,"t_phylum")
bacteroidota_s6_G5 <- selectOTUlevel("Bacteroidota",s6_G5,"t_phylum")
bacteroidota_s6_G6 <- selectOTUlevel("Bacteroidota",s6_G6,"t_phylum")
bacteroidota_s8_G4 <- selectOTUlevel("Bacteroidota",s8_G4,"t_phylum")
bacteroidota_s8_G7 <- selectOTUlevel("Bacteroidota",s8_G7,"t_phylum")
```

### Count OTU level

We want to count how many SCG are assigned to each phylum in our data.

``` r
count_s6_G1 <- getOTUcount(bacteroidota_s6_G1,"t_family")
count_s6_G2 <- getOTUcount(bacteroidota_s6_G2,"t_family")
count_s6_G3 <- getOTUcount(bacteroidota_s6_G3,"t_family")
count_s6_G5 <- getOTUcount(bacteroidota_s6_G5,"t_family")
count_s6_G6 <- getOTUcount(bacteroidota_s6_G6,"t_family")
count_s8_G4 <- getOTUcount(bacteroidota_s8_G4,"t_family")
count_s8_G7 <- getOTUcount(bacteroidota_s8_G7,"t_family")
```

### Available OTUs

We want to see all the OTUs available in our data.

``` r
all_s6_G1 <- getAllOTU(count_s6_G1,"t_family")
all_s6_G2 <- getAllOTU(count_s6_G2,"t_family")
all_s6_G3 <- getAllOTU(count_s6_G3,"t_family")
all_s6_G5 <- getAllOTU(count_s6_G5,"t_family")
all_s6_G6 <- getAllOTU(count_s6_G6,"t_family")
all_s8_G4 <- getAllOTU(count_s8_G4,"t_family")
all_s8_G7 <- getAllOTU(count_s8_G7,"t_family")
all_OTUs_B <- bind_rows(all_s6_G1,all_s6_G2,all_s6_G3,all_s6_G5,all_s6_G6,all_s8_G4,all_s8_G7)
all_OTUs_B <- all_OTUs_B %>% distinct(t_family, .keep_all = FALSE)

rm(all_s6_G1,all_s6_G2,all_s6_G3,all_s6_G5,all_s6_G6,all_s8_G4,all_s8_G7)

kable(head(all_OTUs_B),caption="Head of dataframe")
```

| t_family          |
|:------------------|
| Crocinitomicaceae |
| UBA9320           |
| Flavobacteriaceae |
| BACL11            |
| UA16              |
| Saprospiraceae    |

Head of dataframe

### Set up dataframe for distribution

Time to build the dataframe containing all the SCG counts in our data.

``` r
DF_s6_G1 <- buildDF(count_s6_G1,all_OTUs_B,"t_family")
DF_s6_G2 <- buildDF(count_s6_G2,all_OTUs_B,"t_family")
DF_s6_G3 <- buildDF(count_s6_G3,all_OTUs_B,"t_family")
DF_s6_G5 <- buildDF(count_s6_G5,all_OTUs_B,"t_family")
DF_s6_G6 <- buildDF(count_s6_G6,all_OTUs_B,"t_family")
DF_s8_G4 <- buildDF(count_s8_G4,all_OTUs_B,"t_family")
DF_s8_G7 <- buildDF(count_s8_G7,all_OTUs_B,"t_family")
```

Bind all the dataframes.

``` r
All_samples_bacteroidota <- all_OTUs_B %>% left_join(DF_s6_G1, by="t_family") %>%
  left_join(DF_s6_G2, by="t_family") %>%
  left_join(DF_s6_G3,by="t_family") %>%
  left_join(DF_s6_G5,by="t_family") %>%
  left_join(DF_s6_G6,by="t_family") %>%
  left_join(DF_s8_G4,by="t_family") %>%
  left_join(DF_s8_G7,by="t_family")

names(All_samples_bacteroidota)<-c("OTUs","s6_G1","s6_G2","s6_G3","s6_G5","s6_G6","s8_G4","s8_G7")

kable(head(All_samples_bacteroidota),caption="Head of dataframe")
```

| OTUs              | s6_G1 | s6_G2 | s6_G3 | s6_G5 | s6_G6 | s8_G4 | s8_G7 |
|:------------------|------:|------:|------:|------:|------:|------:|------:|
| Crocinitomicaceae |    96 |    32 |    33 |    54 |    10 |    41 |    74 |
| UBA9320           |    37 |     2 |    36 |     1 |    24 |    29 |     1 |
| Flavobacteriaceae |   974 |   705 |   468 |   738 |   240 |   434 |   732 |
| BACL11            |   113 |   234 |     8 |   160 |     0 |    35 |    88 |
| UA16              |   257 |   206 |    22 |   163 |    19 |   103 |   249 |
| Saprospiraceae    |    35 |     3 |    13 |     0 |    14 |     8 |    28 |

Head of dataframe

### Compute the taxonomic distribution of SCG in each group of samples

``` r
distribution_bacteroidota <- relative_distribution(All_samples_bacteroidota)
kable(head(distribution_bacteroidota),caption="Head of dataframe")
```

| OTUs              |     s6_G1 |      s6_G2 |     s6_G3 |      s6_G5 |     s6_G6 |     s8_G4 |     s8_G7 |
|:------------------|----------:|-----------:|----------:|-----------:|----------:|----------:|----------:|
| Crocinitomicaceae |  5.010438 |  2.2614841 |  4.714286 |  3.6241611 |  3.164557 |  5.408971 |  5.576488 |
| UBA9320           |  1.931107 |  0.1413428 |  5.142857 |  0.0671141 |  7.594937 |  3.825858 |  0.075358 |
| Flavobacteriaceae | 50.835073 | 49.8233216 | 66.857143 | 49.5302013 | 75.949367 | 57.255937 | 55.162020 |
| BACL11            |  5.897704 | 16.5371025 |  1.142857 | 10.7382550 |  0.000000 |  4.617414 |  6.631500 |
| UA16              | 13.413361 | 14.5583039 |  3.142857 | 10.9395973 |  6.012658 | 13.588390 | 18.764130 |
| Saprospiraceae    |  1.826722 |  0.2120141 |  1.857143 |  0.0000000 |  4.430380 |  1.055409 |  2.110023 |

Head of dataframe

``` r
distribution_bacteroidota <- gather(distribution_bacteroidota,group,distribution,s6_G1:s8_G7,factor_key=TRUE)
kable(head(distribution_bacteroidota),caption="Head of dataframe")
```

| OTUs              | group | distribution |
|:------------------|:------|-------------:|
| Crocinitomicaceae | s6_G1 |     5.010438 |
| UBA9320           | s6_G1 |     1.931107 |
| Flavobacteriaceae | s6_G1 |    50.835073 |
| BACL11            | s6_G1 |     5.897704 |
| UA16              | s6_G1 |    13.413361 |
| Saprospiraceae    | s6_G1 |     1.826722 |

Head of dataframe

We delete the SCG attributed to OTUs that have a distribution of 0.

``` r
distribution_bacteroidota <- distribution_bacteroidota[substr(distribution_bacteroidota$distribution,0.1,100) != 0,]
kable(head(distribution_bacteroidota),caption="Head of dataframe")
```

| OTUs              | group | distribution |
|:------------------|:------|-------------:|
| Crocinitomicaceae | s6_G1 |     5.010438 |
| UBA9320           | s6_G1 |     1.931107 |
| Flavobacteriaceae | s6_G1 |    50.835073 |
| BACL11            | s6_G1 |     5.897704 |
| UA16              | s6_G1 |    13.413361 |
| Saprospiraceae    | s6_G1 |     1.826722 |

Head of dataframe

We can assume there are some SCG whose distribution will be inferior to
1%. We will try and delete them.

``` r
lessthan1 <- distribution_bacteroidota[distribution_bacteroidota$n < 1,]
distribution_bacteroidota$OTUs[distribution_bacteroidota$n < 1] <- "OTUs < 1% abundance"
kable(head(distribution_bacteroidota),caption = "Head of dataframe")
```

| OTUs              | group | distribution |
|:------------------|:------|-------------:|
| Crocinitomicaceae | s6_G1 |     5.010438 |
| UBA9320           | s6_G1 |     1.931107 |
| Flavobacteriaceae | s6_G1 |    50.835073 |
| BACL11            | s6_G1 |     5.897704 |
| UA16              | s6_G1 |    13.413361 |
| Saprospiraceae    | s6_G1 |     1.826722 |

Head of dataframe

All done for Bacteroidota. Next step is to see which genus are found in
Flavobacteriaceae.

## Flavobacteriaceae

### Select OTU level

We want to select only the SCG belonging to the family Flavobacteriaceae

``` r
flavo_s6_G1 <- selectOTUlevel("Flavobacteriaceae",s6_G1,"t_family")
flavo_s6_G2 <- selectOTUlevel("Flavobacteriaceae",s6_G2,"t_family")
flavo_s6_G3 <- selectOTUlevel("Flavobacteriaceae",s6_G3,"t_family")
flavo_s6_G5 <- selectOTUlevel("Flavobacteriaceae",s6_G5,"t_family")
flavo_s6_G6 <- selectOTUlevel("Flavobacteriaceae",s6_G6,"t_family")
flavo_s8_G4 <- selectOTUlevel("Flavobacteriaceae",s8_G4,"t_family")
flavo_s8_G7 <- selectOTUlevel("Flavobacteriaceae",s8_G7,"t_family")
```

### Count OTU level

We want to count how many SCG are assigned to each phylum in our data.

``` r
count_s6_G1 <- getOTUcount(flavo_s6_G1,"t_genus")
count_s6_G2 <- getOTUcount(flavo_s6_G2,"t_genus")
count_s6_G3 <- getOTUcount(flavo_s6_G3,"t_genus")
count_s6_G5 <- getOTUcount(flavo_s6_G5,"t_genus")
count_s6_G6 <- getOTUcount(flavo_s6_G6,"t_genus")
count_s8_G4 <- getOTUcount(flavo_s8_G4,"t_genus")
count_s8_G7 <- getOTUcount(flavo_s8_G7,"t_genus")
```

### Available OTUs

We want to see all the OTUs available in our data.

``` r
all_s6_G1 <- getAllOTU(count_s6_G1,"t_genus")
all_s6_G2 <- getAllOTU(count_s6_G2,"t_genus")
all_s6_G3 <- getAllOTU(count_s6_G3,"t_genus")
all_s6_G5 <- getAllOTU(count_s6_G5,"t_genus")
all_s6_G6 <- getAllOTU(count_s6_G6,"t_genus")
all_s8_G4 <- getAllOTU(count_s8_G4,"t_genus")
all_s8_G7 <- getAllOTU(count_s8_G7,"t_genus")
all_OTUs_F <- bind_rows(all_s6_G1,all_s6_G2,all_s6_G3,all_s6_G5,all_s6_G6,all_s8_G4,all_s8_G7)
all_OTUs_F <- all_OTUs_F %>% distinct(t_genus, .keep_all = FALSE)

rm(all_s6_G1,all_s6_G2,all_s6_G3,all_s6_G5,all_s6_G6,all_s8_G4,all_s8_G7)

kable(head(all_OTUs_F),caption="Head of dataframe")
```

| t_genus          |
|:-----------------|
| Hel1-33-131      |
| MS024-2A         |
| Flavobacterium   |
| Leeuwenhoekiella |
| SGZJ01           |
| UBA8316          |

Head of dataframe

### Set up dataframe for distribution

Time to build the dataframe containing all the SCG counts in our data.

``` r
DF_s6_G1 <- buildDF(count_s6_G1,all_OTUs_F,"t_genus")
DF_s6_G2 <- buildDF(count_s6_G2,all_OTUs_F,"t_genus")
DF_s6_G3 <- buildDF(count_s6_G3,all_OTUs_F,"t_genus")
DF_s6_G5 <- buildDF(count_s6_G5,all_OTUs_F,"t_genus")
DF_s6_G6 <- buildDF(count_s6_G6,all_OTUs_F,"t_genus")
DF_s8_G4 <- buildDF(count_s8_G4,all_OTUs_F,"t_genus")
DF_s8_G7 <- buildDF(count_s8_G7,all_OTUs_F,"t_genus")
```

Bind all the dataframes.

``` r
All_samples_flavo <- all_OTUs_F %>% left_join(DF_s6_G1, by="t_genus") %>%
  left_join(DF_s6_G2, by="t_genus") %>%
  left_join(DF_s6_G3,by="t_genus") %>%
  left_join(DF_s6_G5,by="t_genus") %>%
  left_join(DF_s6_G6,by="t_genus") %>%
  left_join(DF_s8_G4,by="t_genus") %>%
  left_join(DF_s8_G7,by="t_genus")

names(All_samples_flavo)<-c("OTUs","s6_G1","s6_G2","s6_G3","s6_G5","s6_G6","s8_G4","s8_G7")

kable(head(All_samples_flavo),caption="Head of dataframe")
```

| OTUs             | s6_G1 | s6_G2 | s6_G3 | s6_G5 | s6_G6 | s8_G4 | s8_G7 |
|:-----------------|------:|------:|------:|------:|------:|------:|------:|
| Hel1-33-131      |    76 |    11 |     1 |    39 |     0 |    33 |    81 |
| MS024-2A         |   102 |    52 |    24 |    79 |     1 |    34 |    52 |
| Flavobacterium   |     8 |     8 |     5 |     0 |     8 |    12 |    24 |
| Leeuwenhoekiella |     1 |     3 |     0 |     1 |     0 |     0 |     0 |
| SGZJ01           |    55 |    50 |    15 |    20 |    11 |    20 |    34 |
| UBA8316          |    43 |    13 |     2 |    93 |     0 |     3 |     5 |

Head of dataframe

### Compute the taxonomic distribution of SCG in each group of samples

``` r
distribution_flavo <- relative_distribution(All_samples_flavo)
kable(head(distribution_flavo),caption="Head of dataframe")
```

| OTUs             |      s6_G1 |     s6_G2 |     s6_G3 |      s6_G5 |     s6_G6 |     s8_G4 |      s8_G7 |
|:-----------------|-----------:|----------:|----------:|-----------:|----------:|----------:|-----------:|
| Hel1-33-131      |  7.8028747 | 1.5602837 | 0.2136752 |  5.2845528 | 0.0000000 | 7.6036866 | 11.0655738 |
| MS024-2A         | 10.4722793 | 7.3758865 | 5.1282051 | 10.7046070 | 0.4166667 | 7.8341014 |  7.1038251 |
| Flavobacterium   |  0.8213552 | 1.1347518 | 1.0683761 |  0.0000000 | 3.3333333 | 2.7649770 |  3.2786885 |
| Leeuwenhoekiella |  0.1026694 | 0.4255319 | 0.0000000 |  0.1355014 | 0.0000000 | 0.0000000 |  0.0000000 |
| SGZJ01           |  5.6468172 | 7.0921986 | 3.2051282 |  2.7100271 | 4.5833333 | 4.6082949 |  4.6448087 |
| UBA8316          |  4.4147844 | 1.8439716 | 0.4273504 | 12.6016260 | 0.0000000 | 0.6912442 |  0.6830601 |

Head of dataframe

``` r
distribution_flavo <- gather(distribution_flavo,group,distribution,s6_G1:s8_G7,factor_key=TRUE)
kable(head(distribution_flavo),caption="Head of dataframe")
```

| OTUs             | group | distribution |
|:-----------------|:------|-------------:|
| Hel1-33-131      | s6_G1 |    7.8028747 |
| MS024-2A         | s6_G1 |   10.4722793 |
| Flavobacterium   | s6_G1 |    0.8213552 |
| Leeuwenhoekiella | s6_G1 |    0.1026694 |
| SGZJ01           | s6_G1 |    5.6468172 |
| UBA8316          | s6_G1 |    4.4147844 |

Head of dataframe

We delete the SCG attributed to OTUs that have a distribution of 0.

``` r
distribution_flavo <- distribution_flavo[substr(distribution_flavo$distribution,0.1,100) != 0,]
kable(head(distribution_flavo),caption="Head of dataframe")
```

| OTUs             | group | distribution |
|:-----------------|:------|-------------:|
| Hel1-33-131      | s6_G1 |    7.8028747 |
| MS024-2A         | s6_G1 |   10.4722793 |
| Flavobacterium   | s6_G1 |    0.8213552 |
| Leeuwenhoekiella | s6_G1 |    0.1026694 |
| SGZJ01           | s6_G1 |    5.6468172 |
| UBA8316          | s6_G1 |    4.4147844 |

Head of dataframe

We can assume there are some SCG whose distribution will be inferior to
1%. We will try and group them.

``` r
lessthan1 <- distribution_flavo[distribution_flavo$distribution < 1,]
distribution_flavo$OTUs[distribution_flavo$distribution < 1] <- "OTUs < 1% abundance"
kable(head(distribution_flavo),caption="Head of dataframe")
```

| OTUs                 | group | distribution |
|:---------------------|:------|-------------:|
| Hel1-33-131          | s6_G1 |    7.8028747 |
| MS024-2A             | s6_G1 |   10.4722793 |
| OTUs \< 1% abundance | s6_G1 |    0.8213552 |
| OTUs \< 1% abundance | s6_G1 |    0.1026694 |
| SGZJ01               | s6_G1 |    5.6468172 |
| UBA8316              | s6_G1 |    4.4147844 |

Head of dataframe

All done for Flavobacteriaceae : time to plot !

To recap, we now have 3 dataframes : - 1 dataframe containing the
taxonomic distribution of the phylum associated to the SCG in our data -
1 dataframe containing the taxonomic distribution of the SCG associated
to the phylum Bacteroidota - 1 dataframe containing the taxonomic
distribution of the SCG associated to the family Flavobacteriaceae

# Plot

We want a plot for each taxonomic level.

First, we pick the color palette :

``` r
colors <- c("#d6506b","#91a700","#4c7367","#96395e","#705186","#934100","#cc9b00",
            "#A9A9A9","#dc8d32","#d33426","#532028","#33303f","#5803bd","#002b62",
            "#ffdd8e","#7ca071","#00d0ad","#e46f00","#94cfc9","#3d3c22","#6bad37",
            "#980092","#6b8cb1","#a3d379","#88afff","#60dd6f","#ff6a54","#d7ffcf",
            "#dfdf4f","#008509","#d9d5ff","#ff246b","#95362f","#a2a34e","#200021",
            "#d1bba5","#552e00","#dc9e5d","#ffab2c","#76de9e","#003a1c","#336400",
            "#004c67","#7c6534","#a07d28","#71e40a","#e8ba00","#6e54c5","#866566",
            "#edb3ff","#d04dff","#da54b5","#01bfd8","#008d54","#432281","#680056",
            "#d38eb1","#4ca191","#d38473","#cfff66","#553222")
```

## Phylum

### Select colors

We need to select the right number of colors.

``` r
colourCountphylum <- length(unique(distribution_phylum$OTUs))
```

We need 21 colors.

``` r
mycolorsphylum <- colors[colourCountphylum:1]
```

### Plot

``` r
Phylum.p <- distribution_plot(distribution_phylum, mycolorsphylum, "Taxonomic distribution of SCG in each group of samples")
Phylum.p
```

![](05-SCG-taxonomic-distribution_files/figure-gfm/unnamed-chunk-34-1.png)<!-- -->

``` r
ggsave("05-SCG-taxonomic-distribution-all.png",Phylum.p,width = 11, height = 8)
```

## Bacteroidota

### Select colors

We need to select the right number of colors.

``` r
colourCountbact <- length(unique(distribution_bacteroidota$OTUs))
```

We need 23 colors.

``` r
mycolorsbact <- colors[colourCountbact:1]
```

### Plot

``` r
Bacteroidota.p <- distribution_plot(distribution_bacteroidota, mycolorsbact, "Taxonomic distribution of SCG associated with the phylum Bacteroidota in each group of samples")
Bacteroidota.p
```

![](05-SCG-taxonomic-distribution_files/figure-gfm/unnamed-chunk-37-1.png)<!-- -->

``` r
ggsave("05-SCG-taxonomic-distribution-phylum.png",Bacteroidota.p,width = 11, height = 8)
```

## Flavobacteriaceae

### Select colors

We need to select the right number of colors.

``` r
colourCountflavo <- length(unique(distribution_flavo$OTUs))
```

We need G1 colors.

``` r
mycolorsflavo <- colors[colourCountflavo:1]
```

### Plot

``` r
Flavo.p <- distribution_plot(distribution_flavo, mycolorsflavo, "Taxonomic distribution of SCG associated with the family Flavobacteriaceae in each group of samples")
Flavo.p
```

![](05-SCG-taxonomic-distribution_files/figure-gfm/unnamed-chunk-40-1.png)<!-- -->

``` r
ggsave("05-SCG-taxonomic-distribution-family.png",Flavo.p,width = 11, height = 8)
```

## All

``` r
title <- ggdraw()+ draw_label("Taxonomic distribution of SCG in every group of samples",
    fontface = 'bold',x = 0,hjust = 0,size = 25)+
    theme(plot.margin = margin(0, 0, 0, 10))

Phylum.p <- distribution_plot(distribution_phylum, mycolorsphylum, "Phylum")+
  theme(legend.text = element_text(size=14))
Bacteroidota.p <- distribution_plot(distribution_bacteroidota, mycolorsbact, "Bacteroidota")+
  theme(legend.text = element_text(size=14))
Flavo.p <- distribution_plot(distribution_flavo, mycolorsflavo, "Flavobacteriaceae")+
  theme(legend.text = element_text(size=14))

plot_row <- plot_grid(Phylum.p,
                      Bacteroidota.p,
                      Flavo.p,
                      labels=c("A", "B","C"),
                      ncol = 2, nrow = 2)

Allsamples.p <- plot_grid(title, plot_row,ncol = 1,rel_heights = c(0.1, 1))
Allsamples.p
```

![](05-SCG-taxonomic-distribution_files/figure-gfm/unnamed-chunk-41-1.png)<!-- -->

``` r
ggsave("05-SCG-taxonomic-distribution-multiplot.png",Allsamples.p,width = 30, height = 18)
```

# End
