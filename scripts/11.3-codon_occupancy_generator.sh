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

# this script is executing the codon occupancy calculation for multiple samples and organizing the output files in a directory  with specific names indicating the sample and codon occupancy information


cd /data/users/hassaf/RNAseq/data

mkdir -p 8-codon_occupancy

/data/users/hassaf/RNAseq/scripts/11.2-codon_occupancy_cal.sh \
/data/users/hassaf/RNAseq/results/5-transcriptome_annotation/transcriptome_SingleLine.fa \
./RPF_KO_Rep1_clpd_tr_no_undesiredRNA_transcriptome.sam

mv ./Codon_occupancy.txt 8-codon_occupancy/RPF_KO_Rep1_Codon_occupancy.txt

/data/users/hassaf/RNAseq/scripts/11.2-codon_occupancy_cal.sh \
/data/users/hassaf/RNAseq/results/5-transcriptome_annotation/transcriptome_SingleLine.fa \
./RPF_KO_Rep2_clpd_tr_no_undesiredRNA_transcriptome.sam

mv ./Codon_occupancy.txt 8-codon_occupancy/RPF_KO_Rep2_Codon_occupancy.txt

/data/users/hassaf/RNAseq/scripts/11.2-codon_occupancy_cal.sh \
/data/users/hassaf/RNAseq/results/5-transcriptome_annotation/transcriptome_SingleLine.fa \
./RPF_WT_Rep1_clpd_tr_no_undesiredRNA_transcriptome.sam

mv ./Codon_occupancy.txt 8-codon_occupancy/RPF_WT_Rep1_Codon_occupancy.txt

/data/users/hassaf/RNAseq/scripts/11.2-codon_occupancy_cal.sh \
/data/users/hassaf/RNAseq/results/5-transcriptome_annotation/transcriptome_SingleLine.fa \
./RPF_WT_Rep2_clpd_tr_no_undesiredRNA_transcriptome.sam

mv ./Codon_occupancy.txt 8-codon_occupancy/RPF_WT_Rep2_Codon_occupancy.txt
