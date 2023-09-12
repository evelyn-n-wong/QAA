#!/bin/bash

#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=interactive               #REQUIRED: which partition to use
#SBATCH --mail-user=evew@uoregon.edu     #optional: if you'd like email
#SBATCH --mail-type=ALL                   #optional: must set email first, what type of email you want
#SBATCH --cpus-per-task=8                 #optional: number of cpus, default is 1
#SBATCH --mem=32GB                        #optional: amount of memory, default is 4GB
#SBATCH --reservation=bgmp-res

conda activate bgmp_star

/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
--outFilterMultimapNmax 3 \
--outSAMunmapped Within KeepPairs \
--alignIntronMax 1000000 --alignMatesGapMax 1000000 \
--readFilesIn /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_paired_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_paired_trimmed_out.fastq \
--genomeDir /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR/ \
--outFileNamePrefix /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR_out/Mouse_QAA_new_28_4D_mbnl_S20_L008_

/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
--outFilterMultimapNmax 3 \
--outSAMunmapped Within KeepPairs \
--alignIntronMax 1000000 --alignMatesGapMax 1000000 \
--readFilesIn /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_paired_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_paired_trimmed_out.fastq \
--genomeDir /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR/ \
--outFileNamePrefix /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR_out/Mouse_QAA_new_3_2B_control_S3_L008_