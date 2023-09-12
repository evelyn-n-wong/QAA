#!/bin/bash

#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=interactive               #REQUIRED: which partition to use
#SBATCH --mail-user=evew@uoregon.edu     #optional: if you'd like email
#SBATCH --mail-type=ALL                   #optional: must set email first, what type of email you want
#SBATCH --cpus-per-task=8                 #optional: number of cpus, default is 1
#SBATCH --mem=32GB                        #optional: amount of memory, default is 4GB
#SBATCH --reservation=bgmp-res

conda activate QAA2
/usr/bin/time -v /projects/bgmp/evew/bioinfo/Bi621/PS/PS8/STAR_parser.py -f /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR_out/Mouse_QAA_new_28_4D_mbnl_S20_L008_Aligned.out.sam 
/usr/bin/time -v /projects/bgmp/evew/bioinfo/Bi621/PS/PS8/STAR_parser.py -f /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR_out/Mouse_QAA_new_3_2B_control_S3_L008_Aligned.out.sam 