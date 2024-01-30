#!/bin/bash

#SBATCH --mail-user=hassan.assaf@students.unibe.ch
#SBATCH --mail-type=fail
#SBATCH --job-name=fastqc_raw_data
#SBATCH --cpus-per-task=1
#SBATCH --time=1:00:00
#SBATCH --mem-per-cpu=1G
#SBATCH --partition=pall
#SBATCH --output=/data/users/hassaf/RNAseq/results/output_%j.o
#SBATCH --error=/data/users/hassaf/RNAseq/results/error_%j.e

#load the module of fastqc:

module load UHTS/Quality_control/fastqc/0.11.9;

#enter the directory of the raw data:

cd /data/users/hassaf/RNAseq/data

# command that run fastqc quality control analysis for all files in directory with name ending in ".fastq.gz" which are the raw data:

fastqc -t 16 *.fastq.gz

