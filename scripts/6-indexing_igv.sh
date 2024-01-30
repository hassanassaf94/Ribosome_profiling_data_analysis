#!/bin/bash

#SBATCH --mail-user=hassan.assaf@students.unibe.ch
#SBATCH --mail-type=fail
#SBATCH --job-name=indexing_igv_visualisation
#SBATCH --time=1:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --partition=pall
#SBATCH --output=/data/users/hassaf/RNAseq/results/output_%j.o
#SBATCH --error=/data/users/hassaf/RNAseq/results/error_%j.e

cd /data/users/hassaf/RNAseq/data

module add UHTS/Analysis/samtools/1.8

#creat bai files for corresponding bam files:

for file in $(ls -d *sorted.bam); \
do echo ${file}; \
samtools index \
-b \
-@ 4 \
${file} \
$(basename ${file} .bam).bai; done
