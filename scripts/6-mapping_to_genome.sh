#!/bin/bash

#SBATCH --mail-user=hassan.assaf@students.unibe.ch
#SBATCH --mail-type=fail
#SBATCH --job-name=mapping_to_genome
#SBATCH --time=2:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8G
#SBATCH --partition=pall
#SBATCH --output=/data/users/hassaf/RNAseq/results/output_%j.o
#SBATCH --error=/data/users/hassaf/RNAseq/results/error_%j.e


module load UHTS/Aligner/bowtie/0.12.9
module load UHTS/Analysis/samtools/1.10


cd /data/users/hassaf/RNAseq/data 

#Use for loop iterate over all files that are not aligned with undesired RNA annotation. For each file we use bowtie tool to map it to the genome.Output is in sam file we convert it to bam file excluding unmapped reads.


for x in $(ls -d *RNA.fastq); \
do echo ${x}; \
bowtie \
-S \
-t \
-p 4 \
-v 1 \
-m 1 \
--best \
--strata \
/data/users/hassaf/RNAseq/results/6-index_bowtie/Homo_sapiens.GRCh38.dna.primary_assembly \
-q ${x} \
2> $(basename ${x} .fastq)_GRCh38_log.txt | \
samtools view \
-h \
-F 4 \
-b > $(basename ${x} .fastq)_GRCh38.bam; done

# Use a for loop to iterate over all produced bam files and use sam tool to sort these bam files. 

for x in $(ls -d *.bam); \
do echo ${x}; \
samtools sort \
-@ 4 \
${x} \
-o $(basename ${x} .bam)_sorted.bam; done

# Remove the unsorted BAM file
rm *GRCh38.bam

