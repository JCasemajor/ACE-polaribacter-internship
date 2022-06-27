select-bacterial-genomes
================
Juliette Casemajor
2/25/2022

-   [Input](#input)
-   [Select the number of bacterial
    genomes](#select-the-number-of-bacterial-genomes)
-   [Expected output](#expected-output)

# Input

The input here is the txt file from
“[anvi-display-contigs-stats](https://anvio.org/help/main/programs/anvi-display-contigs-stats/)”
(Anvio v7.1) for each co-assemby group.

``` r
input <- read.delim2("display_contigs_stats_coassemblies.txt")
head(input)
```

    ##             contigs_db      s6_G1      s6_G2      s6_G3      s6_G5     s6_G6
    ## 1         Total Length 5362574692 4698020398 1177454903 3605771802 812610237
    ## 2          Num Contigs    2537116    2258647     522394    1699560    455897
    ## 3 Num Contigs > 100 kb        129        163         42         45         2
    ## 4  Num Contigs > 50 kb        773        848        274        428        33
    ## 5  Num Contigs > 20 kb       7960       6473       2207       4515       347
    ## 6  Num Contigs > 10 kb      32962      26505       8743      20155      1742
    ##        s8_G4      s8_G7
    ## 1 3015089527 3105183991
    ## 2    1611911    1597735
    ## 3          9         50
    ## 4        182        344
    ## 5       2135       3119
    ## 6      10687      13904

# Select the number of bacterial genomes

For further analysis, we will need to extract the number of bacterial
genomes estimated by Anvi’o.

``` bash
#!/bin/bash

awk 'BEGIN{FS=OFS=" "} NR==1{print} NR==30{for (i=3;i<=NF;i++) a[i]=$i} END{printf "genome_bact" OFS; for (i=1; i<=NF;i++) printf a[i] OFS; printf "\n"}' $* > genome-bact.txt
```

# Expected output

``` r
output <- read.delim2("genome-bact.txt",sep="\t")
head(output)
```

    ##    contigs_db s6_G1 s6_G2 s6_G3 s6_G5 s6_G6 s8_G4 s8_G7
    ## 1 genome_bact  1252  1461   178  1214    47   351   386
