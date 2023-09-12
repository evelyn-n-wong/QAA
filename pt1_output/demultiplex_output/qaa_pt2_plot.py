#!/usr/bin/env python
# Author: Evelyn Wong
# Date Created: 2023-09-08
# Last Updated 2023-09-08
# Description: Plot the trimmed read length distributions for both R1 and R2 reads /
#              (on the same plot) You can produce 2 different plots for your 2 different RNA-seq samples. 
#              There are a number of ways you could possibly do this. One useful thing your plot should show, 
#              for example, is whether R1s are trimmed more extensively than R2s, or vice versa. 
#              Comment on whether you expect R1s and R2s to be adapter-trimmed at different rates and why.

import argparse
import gzip
import matplotlib.pyplot as plt

def get_args():
  '''This function gets arguments for FASTQ files from user to be parsed'''
  parser = argparse.ArgumentParser(description="This function retrieves the FASTQ read1 and read2 files of interest to be parsed")
  parser.add_argument("-r1", "--read_one", help = "Enter read1 file", required = True)
  parser.add_argument("-r2", "--read_two", help = "Enter read2 file", required = True)
  parser.add_argument("-pre", "--prefix", help = "Enter a prefix for plot title", required = True)
  parser.add_argument("-o1", "--output_one", help = "Enter output file", required = True)
  #parser.add_argument("-o2", "--output_two", help = "Enter output file", required = True)
  args = parser.parse_args()
  return args

# Intializing variables 
args = get_args()
read1 = args.read_one
read2 = args.read_two
output = args.output_one
prefix = args.prefix
#output2 = args.output_two

count_dict_r1: dict = {} # dictionary that stores the length of sequences and see how many counts are associated. 
count_dict_r2: dict = {}

#Dictionary for QAA pt 2 plot: length of sequences and see how many counts are associated

with open(read1, "r") as r1, open(read2, "r") as r2:
  header1 = r1.readline() # skip header
  header2 = r2.readline()
  while True:

    if header1 == "":
      break

    sequence_1 = r1.readline().strip() # sequence line
    r1.readline() # skip plus
    r1.readline() # skip qscores

    sequence_2 = r2.readline().strip() # sequence line
    r2.readline() # skip plus
    r2.readline() # skip qscores

    if not sequence_1:
      break

    length_1 = len(sequence_1)
    length_2 = len(sequence_2)

    if not length_1 in count_dict_r1:
      count_dict_r1[length_1] = 1
    else:
      count_dict_r1[length_1] += 1
    
    if not length_2 in count_dict_r2:
      count_dict_r2[length_2] = 1
    else:
      count_dict_r2[length_2] +=1

print(count_dict_r1)
print(count_dict_r2)

fig, axes = plt.subplots(1, 2)

axes[0].bar(count_dict_r1.keys(), count_dict_r1.values())
axes[0].set_xlabel("Read Length")
axes[0].set_ylabel("Frequency")
axes[0].set_title("R1 Read Length Frequencies")

axes[1].bar(count_dict_r2.keys(), count_dict_r2.values())
axes[1].set_xlabel("Read Length")
axes[1].set_ylabel("Frequency")
axes[1].set_title("R2 Read Length Frequencies")

fig.suptitle(f'{prefix} Trimmed Read Length Distribution')
plt.yscale("log")
plt.tight_layout()
plt.savefig(f'{output}.png')

# plt.bar(count_dict_r1.keys(), count_dict_r1.values())
# plt.bar(count_dict_r2.keys(), count_dict_r2.values())
# plt.xlabel("Read Length")
# plt.ylabel("Frequency")
# plt.title("Trimmed Read Length Distributions")
# plt.legend()
# plt.show()


