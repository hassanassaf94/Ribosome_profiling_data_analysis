#!/bin/bash

#SBATCH --mail-user=hassan.assaf@students.unibe.ch
#SBATCH --mail-type=fail
#SBATCH --job-name=cut_adapter
#SBATCH --time=2:00:00
#SBATCH --partition=pall
#SBATCH --output=/data/users/hassaf/RNAseq/results/output_%j.o
#SBATCH --error=/data/users/hassaf/RNAseq/results/error_%j.e

cd /data/users/hassaf/RNAseq/data

#load modules

module load UHTS/Quality_control/cutadapt/2.5


#iterates over all files in the current directory with a ".fastq.gz" extension.

#For each file, it echoes the filename, and then it runs cutadapt with the specified parameters:

# -a CTGTAGGCACCATCAAT: Specify the 3' adapter sequence to be removed
# -q 25: Set the quality threshold for trimming.
# --minimum-length 25: Discard reads that become shorter than 25 bases after trimming.
# --discard-untrimmed: Discard reads if the adapter is not found.
# -o $(basename ${x} .fastq.gz)_clpd.fastq.gz: Specify the output filename.
# ${x}: Input FASTQ file.
# Redirect standard output to a log file named $(basename ${x} .fastq.gz)_clpd_log.txt.


# Clip 3' adapter:

for x in $(ls -d *.fastq.gz); do echo ${x}; \
cutadapt \
-j 4 \
-a CTGTAGGCACCATCAAT \
-q 25 \
--minimum-length 25 \
--discard-untrimmed \
-o $(basename ${x} .fastq.gz)_clpd.fastq.gz \
${x} 1> $(basename ${x} .fastq.gz)_clpd_log.txt; done


#Then iterates over all files in the current directory that end with "_clpd.fastq.gz" (output from 3' adapter clip).

#For each file, it echoes the filename, and then it runs cutadapt again with the specified parameters:

# --cut -4: Trim 4 nucleotides from the 3' end.



# Trim 4 nt (randomized bases) from the 3' end
for x in $(ls -d *_clpd.fastq.gz); do echo ${x}; \
cutadapt \
-j 4 \
-q 25 \
--cut -4 \
--minimum-length 25 \
-o $(basename ${x} .fastq.gz)_tr.fastq.gz \
${x} 1> $(basename ${x} .fastq.gz)_tr_log.txt; done


