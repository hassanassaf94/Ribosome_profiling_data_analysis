#!/bin/bash
#SBATCH --mail-user=hassan.assaf@students.unibe.ch
#SBATCH --mail-type=fail
#SBATCH --job-name=FeatureCounts
#SBATCH --cpus-per-task=8
#SBATCH --time=2:00:00
#SBATCH --mem-per-cpu=3G
#SBATCH --partition=pall
#SBATCH --output=/data/users/hassaf/RNAseq/results/output_%j.o
#SBATCH --error=/data/users/hassaf/RNAseq/results/error_%j.e


cd /data/users/hassaf/RNAseq/data

mkdir -p 7-featurecount


module load UHTS/Analysis/subread/2.0.1

# use featureCounts tool to count reads on coding sequences CDS. Output CDS_counts_processed.txt file contains information about geneID and the count for each sample on the coding sequences and will be used for differential expression analysis.

# Count reads on CDS
featureCounts \
-T 8 \
-t CDS \
-g gene_id \
-a /data/users/hassaf/RNAseq/results/4-genome_annotation/Homo_sapiens.GRCh38.110.gtf \
-o 7-featurecount/CDS_counts_rawfile.txt *_GRCh38_sorted.bam


# Extract GeneID and Sample columns 
cut -f 1,7-10 7-featurecount/CDS_counts_rawfile.txt > 7-featurecount/CDS_counts_processed.txt

# use featurecounts tool to count reads on exonic regions and categorize them by gene biotype. output file contain information about gene biotypes and corresponding counts for each sample on exonic regions.

#Extract reads mapped to different biotypes
featureCounts \
-T 8 \
-t exon \
-g gene_biotype \
-a /data/users/hassaf/RNAseq/results/4-genome_annotation/Homo_sapiens.GRCh38.110.gtf \
-o 7-featurecount/biotype_counts_rawfile.txt *_GRCh38_sorted.bam

# Extract Biotype and Sample columns

cut -f 1,7-10 7-featurecount/biotype_counts_rawfile.txt > 7-featurecount/biotype_counts_processed.txt
