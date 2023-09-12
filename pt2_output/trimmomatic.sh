#!/bin/bash

#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=interactive               #REQUIRED: which partition to use
#SBATCH --mail-user=evew@uoregon.edu     #optional: if you'd like email
#SBATCH --mail-type=ALL                   #optional: must set email first, what type of email you want
#SBATCH --cpus-per-task=8                 #optional: number of cpus, default is 1
#SBATCH --mem=32GB                        #optional: amount of memory, default is 4GB
#SBATCH --reservation=bgmp-res

conda activate QAA2

#trimmomatic PE -phred33 [input] <path to R1> <path to R2> [output] <path to R1_paired> <path to R1_unpaired> <path to R2_paired> <path to R2_unpaired>

/usr/bin/time trimmomatic PE -phred33 /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_out.fastq \
    /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_out.fastq \
    /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/trimmomatic/28_4D_mbnl_S20_L008_R1_001_paired_trimmed_out.fastq \
    /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/trimmomatic/28_4D_mbnl_S20_L008_R1_001__unpaired_trimmed_out.fastq \
    /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/trimmomatic/28_4D_mbnl_S20_L008_R2_001_paired_trimmed_out.fastq \
    /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/trimmomatic/28_4D_mbnl_S20_L008_R2_001_unpaired_trimmed_out.fastq \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35
/usr/bin/time trimmomatic PE -phred33 /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_out.fastq \
    /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_out.fastq \
    /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/trimmomatic/3_2B_control_S3_L008_R1_001_paired_trimmed_out.fastq \
    /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/trimmomatic/3_2B_control_S3_L008_R1_001_unpaired_trimmed_out.fastq \
    /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/trimmomatic/3_2B_control_S3_L008_R2_001_paired_trimmed_out.fastq \
    /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/trimmomatic/3_2B_control_S3_L008_R2_001_unpaired_trimmed_out.fastq \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35