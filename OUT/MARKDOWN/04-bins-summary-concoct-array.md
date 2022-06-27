04-bins-summary-concoct-array
================
Juliette Casemajor
6/27/2022

We want to get the summary of the CONCOCT bins imported to Anvi’o. We
use the command
“[anvi-summarize](https://anvio.org/help/main/programs/anvi-summarize/)”.

``` bash
#!/usr/bin/env bash
#PBS -q sequentiel
#PBS -l mem=50G
#PBS -l walltime=24:00:00
#PBS -l ncpus=1
#PBS -W umask=002

#PBS -J 1-7

########################################
##      Manage script history         ##
########################################

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

########################################
##      Load environment              ##
########################################

. /appli/bioinfo/anvio/7/env.sh

########################################
##      Load variables                ##
########################################

##Directories
WORKDIR=/home/datawork-lmee-intranet-nos/ACE/03-CO-ASSEMBLY
cd $WORKDIR
CONTIG_DIR="03_CONTIGS"
PROF_DIR="06_MERGED"
BIN_DIR="07_BINNING"

#Select each sample from genome_bact.txt
UPDATED_PBS_ARRAY_INDEX=$(( ${PBS_ARRAY_INDEX} +1 ))

NBGENOME_BACT_FILE=$WORKDIR/$CONTIG_DIR/GENOME_NB/genome-bact.txt
NB_G=$(awk -v nbgen=$UPDATED_PBS_ARRAY_INDEX 'END{print $nbgen}' $NBGENOME_BACT_FILE)
DIV=2
bins=$(( $NB_G/$DIV ))

SAMPLE=$(awk -v pbsarray="$UPDATED_PBS_ARRAY_INDEX" -F" " 'NR==1{print $pbsarray}' $NBGENOME_BACT_FILE)
LOG="$SAMPLE"_summary_anvio_"$TIMESTAMP".log

##Anvio databases
CONTIG_DB=$WORKDIR/$CONTIG_DIR/$SAMPLE-contigs.db
PROF_DB=$WORKDIR/$PROF_DIR/$SAMPLE/PROFILE.db

cd $WORKDIR/$BIN_DIR/"$SAMPLE"_ADJUSTED_"$bins"

########################################
##      Execute script                ##
########################################
anvi-summarize -c $CONTIG_DB \
               -p $PROF_DB \
               -o "BIN_SUMMARY_bact" \
               -C concoct_$bins >> $LOG 2>&1
```
