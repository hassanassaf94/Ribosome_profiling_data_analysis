#!/bin/bash
#SBATCH --mail-user=hassan.assaf@students.unibe.ch
#SBATCH --mail-type=fail
#SBATCH --job-name=multiqc
#SBATCH --cpus-per-task=4
#SBATCH --time=2:00:00
#SBATCH --mem-per-cpu=2G
#SBATCH --partition=pall
#SBATCH --output=/data/users/hassaf/RNAseq/results/output_%j.o
#SBATCH --error=/data/users/hassaf/RNAseq/results/error_%j.e

# MultiQC is a tool that aggregates and summarizes results into a single, comprehensive report

cd /data/users/hassaf/RNAseq/data

module load UHTS/Analysis/MultiQC/1.8

multiqc .



