#!/bin/bash
#SBATCH --mail-user=hassan.assaf@students.unibe.ch
#SBATCH --mail-type=fail
#SBATCH --job-name=codon_occupancy
#SBATCH --cpus-per-task=4
#SBATCH --time=2:00:00
#SBATCH --mem-per-cpu=2G
#SBATCH --partition=pall
#SBATCH --output=/data/users/hassaf/RNAseq/results/output_%j.o
#SBATCH --error=/data/users/hassaf/RNAseq/results/error_%j.e


# This script use for loop  to align each FASTQ file to a transcriptome index using Bowtie. It then prints the file name and redirects both standard output and standard error to log files specific to each input FASTQ file.


cd /data/users/hassaf/RNAseq/data

module load UHTS/Aligner/bowtie/1.2.0

for x in $(ls -d *RNA.fastq); \
do echo ${x}; \
bowtie \
-t \
-p 4 \
-v 1 \
-m 1 \
--best \
--strata \
--norc \
/data/users/hassaf/RNAseq/results/6-index_bowtie/transcriptome \
-q ${x} \
-S $(basename ${x} .fastq)_transcriptome.sam 2> $(basename ${x} .fastq)_transcriptome_log.txt; done
