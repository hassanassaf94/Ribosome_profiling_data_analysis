#!/bin/bash

#SBATCH --mail-user=hassan.assaf@students.unibe.ch
#SBATCH --mail-type=fail
#SBATCH --job-name=Indexing
#SBATCH --cpus-per-task=1
#SBATCH --time=3:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --partition=pall
#SBATCH --output=/data/users/hassaf/RNAseq/results/output_%j.o
#SBATCH --error=/data/users/hassaf/RNAseq/results/error_%j.e


module load UHTS/Aligner/bowtie/1.2.0


cd /data/users/hassaf/RNAseq/results/6-index_bowtie

# using the Bowtie software to build indexes for three different datasets: "undesired" RNAs, the human genome and a transcriptome:

# For the "undesired" RNAs

bowtie-build undesiredRNA.fa undesiredRNA

# For the human genome

bowtie-build Homo_sapiens.GRCh38.dna.primary_assembly.fa Homo_sapiens.GRCh38.dna.primary_assembly



# For the transcriptome

bowtie-build transcriptome.fa transcriptome

