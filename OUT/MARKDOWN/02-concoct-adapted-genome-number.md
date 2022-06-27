02-concoct-adapted-genome-number
================
Juliette Casemajor
6/27/2022

We have 7 co-assembly groups of contigs. We need to run
[CONCOCT](https://concoct.readthedocs.io/en/latest/) on each groups. In
order to do that, we have to set the maximum number of genomes that
CONCOCT will determine. Here, the number is : number of bacterial
genomes / 2. We will use the output from
[01-select-bacterial-genomes](https://github.com/JCasemajor/ACE-polaribacter-internship/blob/main/01-select-bacterial-genomes.Rmd)
and the contigs fasta files.

``` bash
#!/usr/bin/env bash
#PBS -N concoct
#PBS -q mpi_1
#PBS -l select=1:ncpus=28:mem=120gb
#PBS -l walltime=48:00:00
#PBS -J 1-7

WORKDIR=/home/datawork-lmee-intranet-nos/ACE/03-CO-ASSEMBLY
cd $WORKDIR

. /etc/profile.d/modules.sh
module load singularity/3.4.1

UPDATED_PBS_ARRAY_INDEX=$(( ${PBS_ARRAY_INDEX} +1 ))

NBGENOME_BACT_FILE=$WORKDIR/03_CONTIGS/GENOME_NB/genome-bact.txt
NB_G=$(awk -v nbgen=$UPDATED_PBS_ARRAY_INDEX 'END{print $nbgen}' $NBGENOME_BACT_FILE)
DIV=2
bins=$(( $NB_G/$DIV ))

concoct=/home/datawork-lmee-intranet-nos/ABYSS_Metagenomics/singularity/concoct.sif

sample=$(awk -v pbsarray="$UPDATED_PBS_ARRAY_INDEX" -F" " 'NR==1{print $pbsarray}' $NBGENOME_BACT_FILE)

folder=$WORKDIR/07_BINNING/${sample}_ADJUSTED_${bins}
mkdir -p ${folder}

bed=${folder}/${sample}.10K.bed
fa=${folder}/${sample}.10K.fa

fasta=$WORKDIR/02_FASTA/${sample}/${sample}-contigs-prefix-formatted-only.fa
bam=$WORKDIR/04_MAPPING/${sample}

singularity exec -B /home/datawork-bioinfo-ss/ ${concoct} cut_up_fasta.py ${fasta} -c 10000 -o 0 --merge_last -b ${bed} >& ${fa} 2> cut_up_fasta.o${PBS_JOBID%.*}

singularity exec -B /home/datawork-bioinfo-ss/ ${concoct} concoct_coverage_table.py ${bed} ${bam}/*.bam >& ${folder}/coverage_table.tsv 2> concoct_coverage_table_${PBS_JOBNAME}.o${PBS_JOBID%.*}

singularity exec -B /home/datawork-bioinfo-ss/ ${concoct} concoct --clusters ${bins} -t ${NCPUS} --composition_file ${fa} --coverage_file ${folder}/coverage_table.tsv -b ${folder}/ >& concoct_${PBS_JOBNAME}.o${PBS_JOBID%.*} 2>&1

singularity exec -B /home/datawork-bioinfo-ss/ ${concoct} merge_cutup_clustering.py ${folder}/clustering_gt1000.csv >& ${folder}/clustering_merged.csv 2> merge_${PBS_JOBNAME}.o${PBS_JOBID%.*}
```
