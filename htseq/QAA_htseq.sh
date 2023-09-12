#!/bin/bash

#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=interactive               #REQUIRED: which partition to use
#SBATCH --mail-user=evew@uoregon.edu     #optional: if you'd like email
#SBATCH --mail-type=ALL                   #optional: must set email first, what type of email you want
#SBATCH --cpus-per-task=8                 #optional: number of cpus, default is 1
#SBATCH --mem=32GB                        #optional: amount of memory, default is 4GB
#SBATCH --reservation=bgmp-res

conda activate QAA2

#htseq-count [options] <alignment_files> <gtf_file>

/usr/bin/time htseq-count --stranded=yes /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/STAR_out/Mouse_QAA_new_28_4D_mbnl_S20_L008_Aligned.out.sam /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/STAR/Mus_musculus.GRCm39.110.gtf > /projects/bgmp/evew/bioinfo/Bi623/QAA/htseq/stranded_Mouse_QAA_new_28_4D_mbnl_S20_L008_count.txt 
/usr/bin/time htseq-count --stranded=reverse /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/STAR_out/Mouse_QAA_new_28_4D_mbnl_S20_L008_Aligned.out.sam /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/STAR/Mus_musculus.GRCm39.110.gtf > /projects/bgmp/evew/bioinfo/Bi623/QAA/htseq/rev_stranded_Mouse_QAA_new_28_4D_mbnl_S20_L008_count.txt 
/usr/bin/time htseq-count --stranded=yes /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/STAR_out/Mouse_QAA_new_3_2B_control_S3_L008_Aligned.out.sam  /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/STAR/Mus_musculus.GRCm39.110.gtf > /projects/bgmp/evew/bioinfo/Bi623/QAA/htseq/stranded_Mouse_QAA_new_3_2B_control_S3_L008_count.txt 
/usr/bin/time htseq-count --stranded=reverse /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/STAR_out/Mouse_QAA_new_3_2B_control_S3_L008_Aligned.out.sam  /projects/bgmp/evew/bioinfo/Bi623/QAA/pt2_output/STAR/Mus_musculus.GRCm39.110.gtf > /projects/bgmp/evew/bioinfo/Bi623/QAA/htseq/rev_stranded_Mouse_QAA_new_3_2B_control_S3_L008_count.txt 
