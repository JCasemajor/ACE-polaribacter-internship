03-integrate-CONCOCT-res-to-anvio-array
================
Juliette Casemajor
2/25/2022

For each group of co-assembly, CONCOCT created a set of bins. These bins
need to be imported to Anvi’o as a collection. We will use the function
“[anvi-import-collection](https://anvio.org/help/7/programs/anvi-import-collection/)”.

``` bash
#!/usr/bin/env bash
#PBS -q sequentiel
#PBS -l mem=20G
#PBS -l walltime=24:00:00
#PBS -l ncpus=1
#PBS -W umask=002
#PBS -J 1-7

########################################
##      Manage script history         ##
########################################

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)


##      Load environment              ##
########################################

. /appli/bioinfo/anvio/7/env.sh

########################################
##      Load variables                ##
########################################

WORKDIR=/home/datawork-lmee-intranet-nos/ACE/03-CO-ASSEMBLY
cd $WORKDIR
CONTIG_DIR="03_CONTIGS"
PROF_DIR="06_MERGED"
BIN_DIR="07_BINNING"

UPDATED_PBS_ARRAY_INDEX=$(( ${PBS_ARRAY_INDEX} +1 ))

NBGENOME_BACT_FILE=$WORKDIR/$CONTIG_DIR/GENOME_NB/genome-bact.txt
NB_G=$(awk -v nbgen=$UPDATED_PBS_ARRAY_INDEX 'END{print $nbgen}' $NBGENOME_BACT_FILE)
DIV=5
bins=$(( $NB_G/$DIV ))

SAMPLE=$(awk -v pbsarray="$UPDATED_PBS_ARRAY_INDEX" -F" " 'NR==1{print $pbsarray}' $NBGENOME_BACT_FILE)
LOG=concoct_to_anvio_$SAMPLE"_"$TIMESTAMP".log"
##Anvio databases
CONTIG_DB=$WORKDIR/$CONTIG_DIR/$SAMPLE-contigs.db

PROF_DB=$WORKDIR/$PROF_DIR/$SAMPLE/PROFILE.db

##Concoct results
NB_CONCOCT=$bins
BIN_SAMPLE=$WORKDIR/$BIN_DIR/"$PREFIX""$SAMPLE"
BIN_RES="$BIN_SAMPLE"_ADJUSTED_$NB_CONCOCT/clustering_merged.csv
##outputs
BIN_TABLE=$(echo $BIN_RES| cut -f 1 -d .)_anvio.bin

########################################
##      Execute script                ##
########################################

##Modify concoct output
tail -n $(($(wc -l $BIN_RES | cut -f 1 -d" ") -1)) $BIN_RES|sed 's/,/\t/g' |  awk '$2="concoct_"$2' | sed 's/ /\t/g' > $BIN_TABLE

anvi-import-collection -C concoct_$bins \
                        -p $PROF_DB \
                        -c $CONTIG_DB \
                        --contigs-mode $BIN_TABLE >> $LOG 2>&1
```
