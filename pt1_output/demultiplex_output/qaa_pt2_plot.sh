#!/bin/bash
#Author: Evelyn Wong
#Date Created: 2023-09-08
#Description: Produce plots of per-base q-score dist for R1 and R2 reads and plots of per-base N content

#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=interactive               #REQUIRED: which partition to use
#SBATCH --mail-user=evew@uoregon.edu     #optional: if you'd like email
#SBATCH --mail-type=ALL                   #optional: must set email first, what type of email you want
#SBATCH --cpus-per-task=8                 #optional: number of cpus, default is 1
#SBATCH --mem=16GB                        #optional: amount of memory, default is 4GB
#SBATCH --reservation=bgmp-res

conda activate QAA2 

/usr/bin/time -v /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/qaa_pt2_plot.py -r1 /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_paired_trimmed_out.fastq -r2 /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_paired_trimmed_out.fastq -pre Reads_28_4D_mbnl -o1 /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R12
/usr/bin/time -v /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/qaa_pt2_plot.py -r1 /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_paired_trimmed_out.fastq -r2 /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_paired_trimmed_out.fastq -pre Reads_3_2B_control -o1 /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R12