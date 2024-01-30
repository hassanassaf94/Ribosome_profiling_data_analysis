#!/bin/bash

#SBATCH --mail-user=hassan.assaf@students.unibe.ch
#SBATCH --mail-type=fail
#SBATCH --job-name=faToTwoBit
#SBATCH --time=1:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2G
#SBATCH --partition=pall
#SBATCH --output=/data/users/hassaf/RNAseq/results/output_%j.o
#SBATCH --error=/data/users/hassaf/RNAseq/results/error_%j.e

cd /data/users/hassaf/RNAseq/results/4-genome_annotation

module load  SequenceAnalysis/blat/36

# converting genome fasta file to 2bit format needed as input for qc analysis:

faToTwoBit Homo_sapiens.GRCh38.dna.primary_assembly.fa  Homo_sapiens.GRCh38.dna.primary_assembly.2bit



