#!/bin/bash
#Author: Evelyn Wong
#Date Created: 2023-09-06
#Description: Produce plots of per-base q-score dist for R1 and R2 reads and plots of per-base N content

#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=compute               #REQUIRED: which partition to use
#SBATCH --mail-user=evew@uoregon.edu     #optional: if you'd like email
#SBATCH --mail-type=ALL                   #optional: must set email first, what type of email you want
#SBATCH --cpus-per-task=8                 #optional: number of cpus, default is 1
#SBATCH --mem=16GB                        #optional: amount of memory, default is 4GB

module spider fastq
module load fastqc/0.11.5

dir1=/projects/bgmp/shared/2017_sequencing/demultiplexed/28_4D_mbnl_S20_L008_R1_001.fastq.gz
dir2=/projects/bgmp/shared/2017_sequencing/demultiplexed/28_4D_mbnl_S20_L008_R2_001.fastq.gz
dir3=/projects/bgmp/shared/2017_sequencing/demultiplexed/3_2B_control_S3_L008_R1_001.fastq.gz
dir4=/projects/bgmp/shared/2017_sequencing/demultiplexed/3_2B_control_S3_L008_R2_001.fastq.gz

fastqc -o /projects/bgmp/evew/bioinfo/Bi623/QAA/ $dir1
fastqc -o /projects/bgmp/evew/bioinfo/Bi623/QAA/ $dir2
fastqc -o /projects/bgmp/evew/bioinfo/Bi623/QAA/ $dir3
fastqc -o /projects/bgmp/evew/bioinfo/Bi623/QAA/ $dir4