#!/bin/bash

#SBATCH --mail-user=hassan.assaf@students.unibe.ch
#SBATCH --mail-type=fail
#SBATCH --job-name=remove_undesiredRNA
#SBATCH --time=2:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8G
#SBATCH --partition=pall
#SBATCH --output=/data/users/hassaf/RNAseq/results/output_%j.o
#SBATCH --error=/data/users/hassaf/RNAseq/results/error_%j.e


module load UHTS/Aligner/bowtie/0.12.9


cd /data/users/hassaf/RNAseq/data


#This script uses a for loop to iterate over files in the current directory that match the pattern "*tr.fastq.gz."
#For each file, it echoes the filename using echo ${i}.
#It then uses gunzip -cd ${i} to decompress the FASTQ file and stream the output.
#The output is piped (|) as input to the bowtie command.
# -S: Output in SAM format.
# -t: Print time and memory usage statistics.
# /data/users/hassaf/RNAseq/results/6-index_bowtie/undesiredRNA: Path to the Bowtie index for "undesired" RNA.
# -: Indicates that the input comes from the standard input (piped from gunzip).
# --un $(basename ${i} .fastq.gz)_no_undesiredRNA.fastq: Output file for reads that do not align to "undesired" RNA.
# 2> $(basename ${i} .fastq.gz)_no_undesiredRNA_log.txt: Redirect standard error (stderr) to a log file.
# > /dev/null: Redirect standard output (stdout) to /dev/null (discard it).


# Mapping to undesired RNAs and removing discard all reads that are aligned 

for i in $(ls -d *tr.fastq.gz); \
do echo ${i}; \
gunzip -cd ${i} | \
bowtie \
-S \
-t \
/data/users/hassaf/RNAseq/results/6-index_bowtie/undesiredRNA \
- \
--un $(basename ${i} .fastq.gz)_no_undesiredRNA.fastq 2> $(basename ${i} .fastq.gz)_no_undesiredRNA_log.txt > /dev/null; done



