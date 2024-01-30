
# this script follow this vignette: https://htmlpreview.github.io/?https://github.com/lcalviell/Ribo-seQC/blob/master/RiboseQC.html

# To install Ribo-seQC:
install.packages("devtools")

library("devtools")

install.packages("C:/Users/hassa/OneDrive/Desktop/RiboseQC/RiboseQC_0.99.0.tar.gz", repos = NULL, type="source")

library(RiboseQC)

# first we prepare annotation files:
# load gtf and 2bit file genome annotations.
# to convert fasta file format to 2bit format see script FatToTwoBit.

prepare_annotation_files(annotation_directory = "C:/Users/hassa/OneDrive/Desktop/4-genome_annotation",
                         twobit_file = "C:/Users/hassa/OneDrive/Desktop/4-genome_annotation/Homo_sapiens.GRCh38.dna.primary_assembly.2bit",
                         gtf_file = "C:/Users/hassa/OneDrive/Desktop/4-genome_annotation/Homo_sapiens.GRCh38.110.gtf",
                         scientific_name = "Homo.sapiens",
                         annotation_name = "GRCh38",
                         export_bed_tables_TxDb = F,
                         forge_BSgenome = T,
                         create_TxDb = T)


# Genome mapped sorted-BAM files

genome_bam <- c("C:/Users/hassa/OneDrive/Desktop/4-genome_annotation/RPF_WT_Rep1_clpd_tr_no_undesiredRNA_GRCh38_sorted.bam",
                "C:/Users/hassa/OneDrive/Desktop/4-genome_annotation/RPF_WT_Rep2_clpd_tr_no_undesiredRNA_GRCh38_sorted.bam",
                "C:/Users/hassa/OneDrive/Desktop/4-genome_annotation/RPF_KO_Rep1_clpd_tr_no_undesiredRNA_GRCh38_sorted.bam",
                "C:/Users/hassa/OneDrive/Desktop/4-genome_annotation/RPF_KO_Rep2_clpd_tr_no_undesiredRNA_GRCh38_sorted.bam")

# rannot file is output of prepare annotation files command above.  

load_annotation("C:/Users/hassa/OneDrive/Desktop/4-genome_annotation/Homo_sapiens.GRCh38.110.gtf_Rannot")



# Ribo-seQC analysis and report generation

RiboseQC_analysis(annotation_file ="C:/Users/hassa/OneDrive/Desktop/4-genome_annotation/Homo_sapiens.GRCh38.110.gtf_Rannot",
                  bam_files = genome_bam,
                  fast_mode = T,
                  report_file = "C:/Users/hassa/OneDrive/Desktop/4-genome_annotation/RPF_samples_QC.html",
                  sample_names = c("WT_Rep1", "WT_Rep2",
                                   "KO_Rep1", "KO_Rep2"),
                  dest_names = c("WT_Rep1", "WT_Rep2",
                                 "KO_Rep1", "KO_Rep2"),
                  write_tmp_files = F)
