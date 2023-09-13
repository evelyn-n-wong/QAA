QAA Lab Notebook
Author: Evelyn Wong 
Description: Bi623 QAA Assignment Lab Notebook

__9-6-2023__

Ran fastQC on files:

Elapsed time:

	User time (seconds): 60.82
	System time (seconds): 2.63
	Percent of CPU this job got: 97%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:04.75

	User time (seconds): 61.13
	System time (seconds): 3.05
	Percent of CPU this job got: 98%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:05.19

	User time (seconds): 35.56
	System time (seconds): 1.49
	Percent of CPU this job got: 102%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:36.18

	User time (seconds): 36.41
	System time (seconds): 1.72
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:38.30

Ran demultiplex:

Elapsed time:

	User time (seconds): 228.03
	System time (seconds): 1.28
	Percent of CPU this job got: 100%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 3:49.27

	User time (seconds): 228.94
	System time (seconds): 1.26
	Percent of CPU this job got: 100%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 3:49.82

	User time (seconds): 129.54
	System time (seconds): 1.26
	Percent of CPU this job got: 100%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 2:09.91

	User time (seconds): 128.03
	System time (seconds): 1.27
	Percent of CPU this job got: 100%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 2:08.46

__9-7-2023__

Creating conda environment for part 2. Used these commands:

srun --account=bgmp --partition=compute --mem=16G --time=3:00:00 --pty bash
conda create -n QAA
conda activate QAA

To install the two packages: cutadapt and trimmomatic:
conda install -c bioconda cutadapt
conda install -c bioconda trimmomatic 

Checked the version:

cutadapt —version
cutadapt: incorrect version as 2.6 
Should be 4.4

trimmomatic -version
trimmomatic is the correct version (0.39)

Got help from Pete and Leslie. 
Created a new QAA2 environment after trying to reinstall cutadapt with version 4.4 on QAA environment which crashed. Apparently there is an issue with everyone’s mamba as of today (warned by Pete).

conda create -n QAA2 cutadapt=4.4
conda activate QAA2
cutadapt --version
conda install -c bioconda trimmomatic 
trimmomatic -version

cutadapt —help 

How to get the adapters? Looked at biostars and they suggested looking at the adapter content?

__9-8-2023__

Checking location of adapters. 
Initially looked at biostar discussion forums on how to find the adapter sequence. Every single one refers to looking at the adapter sequence results from the FASTQC files. I looked at the adapter_content.png but I’m confused on how to read it.

cutadapt has two options: -a for the adapter at the 3’ end and -g for the 5’ end 

As of right now, it looks like both are at the end? How to check whether they are 3’ or 5’?

Read: 8_4D_mbnl_S20_L008…

Checking number of adapters in file for Read 1:
zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/28_4D_mbnl_S20_L008_R1_001.fastq.gz | grep "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA" | wc -l
56758
(QAA2) [evew@n0185 ~]$ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/28_4D_mbnl_S20_L008_R1_001.fastq.gz | grep "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA" | head
CCCTCACTGGGCACATGGCCACATGCCCCACTCTCTGTTTGGCTATGCCTAGGTTAAGTGTCACCCAGATCGGAAGAGCACACGTCTGAACTCCAGTCACT
CACTGCCGTCTGTTGACACTGACAGGCATGTCACTTGGTTCCTGTGTCCTTTGAAGAGATCGGAAGAGCACACGTCTGAACTCCAGTCACTCGAGAGTATC
GTGGGCACGCAGGTTGGAGCGGTCAGCAAAAGCACGGTTGCAGTGGGAGCAGAGATCGGAAGAGCACACGTCTGAACTCCAGTCACTCGAGAGTATCTCGT
GCTGGCGTGGGATACATGTTGTGGTAGGTGTGCTGGGCTCAGTGCAGGTGTGGATGGGGTCGGGGGAGAGATCGGAAGAGCACACGTCTGAACTCCAGTCA
GACGACAAGGTGCAGGATCGTGCTGGCAAAGAGGAAGTCAGCAAAGGCTCGCTCCGGAGAGATAGATCGGAAGAGCACACGTCTGAACTCCAGTCACTCGA
GGGTGGGGGTGGGGGGCAGTCCCTAGTTGGCTCCAGGCCCAGACAGTCTGGGAGATCGGAAGAGCACACGTCTGAACTCCAGTCACTCGAGAGTATCTCGT
TGTCCACAAACTGCTGCAGTGTGCCCTTGACGGAGAGTAGCCGCGTCAGGTAGATCTCTGAGATCGGAAGAGCACACGTCTGAACTCCAGTCACTCGAGAG
TCAGAGCATCTGTAGCAGAGTTGCCTTGCGCTGCGGACTCCAGGGCGATGCAGAAGGAGCCTAGAGATCGGAAGAGCACACGTCTGAACTCCAGTCACTCG
CTCAGTGTGAAAGGATCTCCAGAAGGAGTGCTCAATCTTGCCCACGCTTTTGATGACCTAGATCGGAAGAGCACACGTCTGAACTCCAGTCACTCGAGAAT
GGCCGTCTTCTGCCCCACTGATTAAGTGCTGGTTGCCATGGAATTTCAGGAGATCGGAAGAGCACACGTCTGAACTCCAGTCACTCGAGAGTATCTCGTAT

Checking number of adapters in file for Read 2:
zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/28_4D_mbnl_S20_L008_R2_001.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" | wc -l 
57626
zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/28_4D_mbnl_S20_L008_R2_001.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" | head
NGGTGACACTTAACCTAGGCATAGCCAAACAGAGAGTGGGGCATGTGGCCATGTGCCCAGTGAGGGAGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAC
CTTCAAAGGACACAGGAACCAAGTGACATGCCTGTCAGTGTCAACAGACGGCAGTGAGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTACTCTCGAGTGT
CTGCTCCCACTGCAACCGTGCTTTTGCTGACCGCTCCAACCTGCGTGCCCACAGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTACTCTCGAGTGTAGAT
CTCGCTTGTGCCATGTGACCTGGGCATGGGCGTGCCCAGGTCACATGGCACAAGCGAGAGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTACTCTCGAGT
CTCCCCCGACCCCATCCACACCTGCACTGAGCCCAGCACACCTACCACAACATGTATCCCACGCCAGCAGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
ATCTCTCCGGAGCGAGCCTTTGCTGACTTCCTCTTTGCCAGCACGATCCTGCACCTTGTCGTCAGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTACTCT
CAGAGATCTACCTGACGCGGCTACTCTCCGTCAAGGGCACACTGCAGCAGTTTGTGGACAAGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTACTCTCGA
CTAGGCTCCTTCTGCATCGCCCTGGAGTCCGCAGCGCAAGGCAACTCTGCTACAGATGCTCTGAAGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTACTC
AGGTCATCAAAAGCGTGGGCAAGATTGAGCACTCCTTCTGGAGATCCTTTCACACTGAGAGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTACTCTCGAG
CCTGAAATTCCATGGCAACCAGCACTTAATCAGTGGGGCAGAAGACGGCCAGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTACTCTCGAGTGTAGATCT


Ike came to the rescue. He said we should be looking at the color of the lines/slope in the adapter_content.png which refers to the Illumina universal adapter. He also referred me to this link: https://knowledge.illumina.com/library-preparation/general/library-preparation-general-reference_material-list/000001314

The adapters are listed as below:
Read 1: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA

Read 2: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT

This matches with the one that Leslie also put up. 

According the manual:
“cutadapt removes adapter sequences from high-throughput sequencing reads.

Usage:
    cutadapt -a ADAPTER [options] [-o output.fastq] input.fastq

For paired-end reads:
    cutadapt -a ADAPT1 -A ADAPT2 [options] -o out1.fastq -p out2.fastq in1.fastq in2.fastq”

Will use the paired-end reads from the manual.

cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_out.fastq -p /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_out.fastq /projects/bgmp/shared/2017_sequencing/demultiplexed/3_2B_control_S3_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/3_2B_control_S3_L008_R2_001.fastq.gz

Output: 

This is cutadapt 4.4 with Python 3.10.12
Command line parameters: -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_out.fastq -p /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_out.fastq /projects/bgmp/shared/2017_sequencing/demultiplexed/3_2B_control_S3_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/3_2B_control_S3_L008_R2_001.fastq.gz
Processing paired-end reads on 1 core ...
Done           00:00:39     6,873,509 reads @   5.7 µs/read;  10.50 M reads/minute
Finished in 39.267 s (5.713 µs/read; 10.50 M reads/minute).

=== Summary ===

Total read pairs processed:          6,873,509
  Read 1 with adapter:                 219,477 (3.2%)
  Read 2 with adapter:                 268,119 (3.9%)
Pairs written (passing filters):     6,873,509 (100.0%)

Total basepairs processed: 1,388,448,818 bp
  Read 1:   694,224,409 bp
  Read 2:   694,224,409 bp
Total written (filtered):  1,384,906,999 bp (99.7%)
  Read 1:   692,563,098 bp
  Read 2:   692,343,901 bp

=== First read: Adapter 1 ===

Sequence: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA; Type: regular 3'; Length: 33; Trimmed: 219477 times

Minimum overlap: 3
No. of allowed errors:
1-9 bp: 0; 10-19 bp: 1; 20-29 bp: 2; 30-33 bp: 3

Bases preceding removed adapters:
  A: 22.7%
  C: 30.0%
  G: 31.7%
  T: 15.4%
  none/other: 0.2%

Overview of removed sequences
length	count	expect	max.err	error counts
3	125616	107398.6	0	125616
4	29187	26849.6	0	29187
5	9643	6712.4	0	9643
6	3667	1678.1	0	3667
7	3112	419.5	0	3112
8	2927	104.9	0	2927
9	2755	26.2	0	2612 143
10	2853	6.6	1	2606 247
11	2612	1.6	1	2484 128
12	2343	0.4	1	2259 84
13	2161	0.1	1	2062 99
14	2109	0.0	1	2033 76
15	2008	0.0	1	1934 74
16	1936	0.0	1	1861 75
17	1778	0.0	1	1691 87
18	1557	0.0	1	1469 86 2
19	1540	0.0	1	1483 57
20	1401	0.0	2	1336 48 17
21	1345	0.0	2	1266 68 11
22	1268	0.0	2	1196 60 12
23	1192	0.0	2	1126 61 5
24	1052	0.0	2	996 46 10
25	1077	0.0	2	1006 59 12
26	984	0.0	2	911 63 10
27	890	0.0	2	835 46 9
28	879	0.0	2	828 41 10
29	834	0.0	2	792 37 5
30	746	0.0	3	689 47 7 3
31	698	0.0	3	646 41 7 4
32	650	0.0	3	601 38 8 3
33	641	0.0	3	595 43 1 2
34	562	0.0	3	527 29 4 2
35	469	0.0	3	447 20 2
36	481	0.0	3	443 31 4 3
37	446	0.0	3	420 22 3 1
38	421	0.0	3	391 27 3
39	412	0.0	3	374 29 4 5
40	351	0.0	3	329 15 5 2
41	329	0.0	3	315 13 1
42	296	0.0	3	268 22 6
43	296	0.0	3	274 18 2 2
44	279	0.0	3	254 20 2 3
45	246	0.0	3	231 11 3 1
46	237	0.0	3	212 18 4 3
47	213	0.0	3	202 10 0 1
48	198	0.0	3	186 9 0 3
49	199	0.0	3	184 13 2
50	185	0.0	3	169 15 0 1
51	150	0.0	3	133 15 1 1
52	148	0.0	3	139 8 0 1
53	126	0.0	3	117 7 1 1
54	116	0.0	3	106 6 4
55	112	0.0	3	103 6 3
56	94	0.0	3	88 5 0 1
57	122	0.0	3	113 6 3
58	98	0.0	3	96 1 0 1
59	108	0.0	3	99 7 2
60	92	0.0	3	86 5 0 1
61	86	0.0	3	80 4 1 1
62	81	0.0	3	76 3 1 1
63	75	0.0	3	71 4
64	68	0.0	3	61 6 0 1
65	58	0.0	3	49 9
66	60	0.0	3	51 5 1 3
67	44	0.0	3	40 4
68	45	0.0	3	40 5
69	40	0.0	3	38 1 1
70	45	0.0	3	39 4 2
71	51	0.0	3	47 4
72	31	0.0	3	30 1
73	27	0.0	3	23 2 1 1
74	17	0.0	3	16 1
75	16	0.0	3	16
76	15	0.0	3	14 0 0 1
77	12	0.0	3	11 0 0 1
78	10	0.0	3	10
79	9	0.0	3	9
80	4	0.0	3	3 1
81	4	0.0	3	4
82	2	0.0	3	2
83	4	0.0	3	3 1
84	4	0.0	3	4
85	5	0.0	3	4 1
86	3	0.0	3	3
87	1	0.0	3	1
88	2	0.0	3	2
89	5	0.0	3	4 0 1
90	1	0.0	3	1
92	2	0.0	3	2
96	1	0.0	3	1
98	2	0.0	3	2
101	400	0.0	3	0 292 102 6


=== Second read: Adapter 2 ===

Sequence: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT; Type: regular 3'; Length: 33; Trimmed: 268119 times

Minimum overlap: 3
No. of allowed errors:
1-9 bp: 0; 10-19 bp: 1; 20-29 bp: 2; 30-33 bp: 3

Bases preceding removed adapters:
  A: 26.4%
  C: 29.1%
  G: 33.9%
  T: 10.4%
  none/other: 0.1%

Overview of removed sequences
length	count	expect	max.err	error counts
3	163492	107398.6	0	163492
4	35978	26849.6	0	35978
5	10579	6712.4	0	10579
6	4457	1678.1	0	4457
7	3222	419.5	0	3222
8	2968	104.9	0	2968
9	2908	26.2	0	2669 239
10	2983	6.6	1	2694 289
11	2758	1.6	1	2542 216
12	2432	0.4	1	2321 111
13	2204	0.1	1	2124 80
14	2153	0.0	1	2089 64
15	2036	0.0	1	1953 83
16	1975	0.0	1	1905 70
17	1797	0.0	1	1731 66
18	1586	0.0	1	1522 63 1
19	1588	0.0	1	1530 58
20	1435	0.0	2	1364 56 15
21	1381	0.0	2	1308 60 13
22	1300	0.0	2	1219 63 18
23	1220	0.0	2	1161 52 7
24	1076	0.0	2	1024 46 6
25	1101	0.0	2	1042 46 13
26	1015	0.0	2	949 51 15
27	918	0.0	2	870 37 11
28	920	0.0	2	846 60 12 2
29	858	0.0	2	788 57 10 3
30	780	0.0	3	714 51 8 7
31	734	0.0	3	673 42 11 8
32	684	0.0	3	633 34 9 8
33	667	0.0	3	612 42 10 3
34	596	0.0	3	539 42 9 6
35	503	0.0	3	464 23 8 8
36	506	0.0	3	465 29 7 5
37	474	0.0	3	425 32 9 8
38	453	0.0	3	418 21 9 5
39	445	0.0	3	418 15 7 5
40	384	0.0	3	344 20 13 7
41	359	0.0	3	321 24 8 6
42	316	0.0	3	289 18 5 4
43	322	0.0	3	293 20 4 5
44	303	0.0	3	275 18 7 3
45	270	0.0	3	244 19 3 4
46	253	0.0	3	228 17 6 2
47	237	0.0	3	211 15 4 7
48	226	0.0	3	199 20 4 3
49	217	0.0	3	193 17 4 3
50	203	0.0	3	175 14 7 7
51	169	0.0	3	155 9 3 2
52	166	0.0	3	141 15 7 3
53	140	0.0	3	126 11 0 3
54	139	0.0	3	114 13 9 3
55	127	0.0	3	110 12 3 2
56	115	0.0	3	94 12 6 3
57	138	0.0	3	127 6 4 1
58	125	0.0	3	101 15 6 3
59	130	0.0	3	102 15 6 7
60	107	0.0	3	90 11 4 2
61	103	0.0	3	90 8 2 3
62	102	0.0	3	88 8 5 1
63	87	0.0	3	70 14 3
64	76	0.0	3	69 4 1 2
65	78	0.0	3	60 13 3 2
66	71	0.0	3	62 5 2 2
67	66	0.0	3	47 10 1 8
68	58	0.0	3	50 5 2 1
69	57	0.0	3	44 5 3 5
70	60	0.0	3	47 8 3 2
71	66	0.0	3	59 6 0 1
72	40	0.0	3	37 2 1
73	37	0.0	3	27 8 0 2
74	31	0.0	3	20 2 5 4
75	24	0.0	3	20 2 1 1
76	26	0.0	3	16 5 2 3
77	22	0.0	3	15 4 2 1
78	14	0.0	3	11 1 2
79	14	0.0	3	7 5 2
80	11	0.0	3	5 2 2 2
81	4	0.0	3	4
82	5	0.0	3	4 1
83	8	0.0	3	6 2
84	6	0.0	3	4 0 1 1
85	7	0.0	3	3 2 1 1
86	3	0.0	3	3
87	1	0.0	3	1
88	4	0.0	3	3 0 0 1
89	4	0.0	3	4
90	1	0.0	3	1
92	4	0.0	3	4
94	1	0.0	3	0 0 1
95	1	0.0	3	0 0 0 1
96	2	0.0	3	1 1
98	3	0.0	3	2 0 1
99	1	0.0	3	0 0 1
100	1	0.0	3	0 0 1
101	392	0.0	3	0 295 88 9


cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_out.fastq -p /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_out.fastq /projects/bgmp/shared/2017_sequencing/demultiplexed/28_4D_mbnl_S20_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/28_4D_mbnl_S20_L008_R2_001.fastq.gz

Output:

This is cutadapt 4.4 with Python 3.10.12
Command line parameters: -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_out.fastq -p /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_out.fastq /projects/bgmp/shared/2017_sequencing/demultiplexed/28_4D_mbnl_S20_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/28_4D_mbnl_S20_L008_R2_001.fastq.gz
Processing paired-end reads on 1 core ...
Done           00:01:16    12,428,766 reads @   6.1 µs/read;   9.78 M reads/minute
Finished in 76.290 s (6.138 µs/read; 9.77 M reads/minute).

=== Summary ===

Total read pairs processed:         12,428,766
  Read 1 with adapter:                 743,440 (6.0%)
  Read 2 with adapter:                 841,389 (6.8%)
Pairs written (passing filters):    12,428,766 (100.0%)

Total basepairs processed: 2,510,610,732 bp
  Read 1: 1,255,305,366 bp
  Read 2: 1,255,305,366 bp
Total written (filtered):  2,489,647,234 bp (99.2%)
  Read 1: 1,245,001,943 bp
  Read 2: 1,244,645,291 bp

=== First read: Adapter 1 ===

Sequence: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA; Type: regular 3'; Length: 33; Trimmed: 743440 times

Minimum overlap: 3
No. of allowed errors:
1-9 bp: 0; 10-19 bp: 1; 20-29 bp: 2; 30-33 bp: 3

Bases preceding removed adapters:
  A: 18.6%
  C: 30.3%
  G: 33.8%
  T: 15.9%
  none/other: 1.4%

Overview of removed sequences
length	count	expect	max.err	error counts
3	236507	194199.5	0	236507
4	63948	48549.9	0	63948
5	30561	12137.5	0	30561
6	20792	3034.4	0	20792
7	19499	758.6	0	19499
8	18190	189.6	0	18190
9	18117	47.4	0	17775 342
10	17853	11.9	1	17139 714
11	16682	3.0	1	16125 557
12	16276	0.7	1	15819 457
13	15774	0.2	1	15281 493
14	15325	0.0	1	14751 574
15	14578	0.0	1	14074 504
16	14292	0.0	1	13758 534
17	13354	0.0	1	12810 544
18	13014	0.0	1	12422 572 20
19	12645	0.0	1	12044 580 21
20	11920	0.0	2	11290 551 79
21	11492	0.0	2	10926 494 72
22	11149	0.0	2	10520 549 80
23	10390	0.0	2	9816 495 79
24	9831	0.0	2	9292 463 76
25	9429	0.0	2	8936 423 70
26	8724	0.0	2	8164 501 59
27	8354	0.0	2	7891 406 50 7
28	7854	0.0	2	7346 437 61 10
29	7184	0.0	2	6704 413 60 7
30	6718	0.0	3	6220 422 56 20
31	6382	0.0	3	5940 365 54 23
32	5713	0.0	3	5324 300 61 28
33	5420	0.0	3	5053 307 42 18
34	5091	0.0	3	4749 277 46 19
35	4596	0.0	3	4312 234 35 15
36	4494	0.0	3	4194 259 27 14
37	4025	0.0	3	3752 225 30 18
38	3787	0.0	3	3557 192 25 13
39	3466	0.0	3	3205 218 28 15
40	3064	0.0	3	2882 157 15 10
41	2835	0.0	3	2646 151 26 12
42	2469	0.0	3	2308 136 19 6
43	2196	0.0	3	2070 105 12 9
44	1973	0.0	3	1859 93 14 7
45	1839	0.0	3	1715 99 20 5
46	1661	0.0	3	1525 112 18 6
47	1350	0.0	3	1265 78 6 1
48	1290	0.0	3	1197 80 13
49	1222	0.0	3	1157 47 14 4
50	1033	0.0	3	958 60 10 5
51	914	0.0	3	868 36 7 3
52	863	0.0	3	811 46 4 2
53	710	0.0	3	652 54 2 2
54	648	0.0	3	615 25 5 3
55	596	0.0	3	561 26 7 2
56	521	0.0	3	499 19 1 2
57	429	0.0	3	403 22 4
58	418	0.0	3	397 15 5 1
59	382	0.0	3	363 16 1 2
60	347	0.0	3	329 12 6
61	281	0.0	3	268 11 2
62	256	0.0	3	236 14 3 3
63	226	0.0	3	215 9 0 2
64	214	0.0	3	199 10 2 3
65	202	0.0	3	190 11 1
66	188	0.0	3	178 7 3
67	139	0.0	3	133 4 1 1
68	140	0.0	3	133 6 0 1
69	101	0.0	3	95 5 0 1
70	97	0.0	3	93 1 2 1
71	93	0.0	3	89 2 2
72	75	0.0	3	67 6 0 2
73	56	0.0	3	53 2 1
74	49	0.0	3	47 1 0 1
75	47	0.0	3	45 1 0 1
76	47	0.0	3	41 4 1 1
77	41	0.0	3	40 1
78	36	0.0	3	34 2
79	33	0.0	3	31 0 2
80	31	0.0	3	29 2
81	40	0.0	3	37 3
82	30	0.0	3	28 1 1
83	79	0.0	3	73 3 2 1
84	31	0.0	3	31
85	55	0.0	3	50 4 0 1
86	29	0.0	3	27 2
87	38	0.0	3	35 3
88	23	0.0	3	20 1 1 1
89	31	0.0	3	30 1
90	24	0.0	3	24
91	30	0.0	3	29 1
92	15	0.0	3	15
93	28	0.0	3	26 1 0 1
94	13	0.0	3	13
95	25	0.0	3	23 1 1
96	40	0.0	3	38 2
97	20	0.0	3	19 1
98	21	0.0	3	18 0 2 1
99	9	0.0	3	9
100	14	0.0	3	14
101	10307	0.0	3	32 8911 1260 104


=== Second read: Adapter 2 ===

Sequence: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT; Type: regular 3'; Length: 33; Trimmed: 841389 times

Minimum overlap: 3
No. of allowed errors:
1-9 bp: 0; 10-19 bp: 1; 20-29 bp: 2; 30-33 bp: 3

Bases preceding removed adapters:
  A: 20.2%
  C: 33.2%
  G: 34.1%
  T: 11.4%
  none/other: 1.2%

Overview of removed sequences
length	count	expect	max.err	error counts
3	312018	194199.5	0	312018
4	78435	48549.9	0	78435
5	34248	12137.5	0	34248
6	22068	3034.4	0	22068
7	19563	758.6	0	19563
8	18355	189.6	0	18355
9	18416	47.4	0	17969 447
10	18091	11.9	1	17291 800
11	16959	3.0	1	16315 644
12	16429	0.7	1	15949 480
13	15887	0.2	1	15454 433
14	15419	0.0	1	15000 419
15	14672	0.0	1	14166 506
16	14366	0.0	1	13942 424
17	13456	0.0	1	12994 462
18	13062	0.0	1	12563 496 3
19	12710	0.0	1	12257 447 6
20	11974	0.0	2	11465 438 71
21	11555	0.0	2	11063 440 52
22	11174	0.0	2	10660 464 50
23	10452	0.0	2	10027 375 50
24	9880	0.0	2	9378 430 72
25	9472	0.0	2	9003 411 58
26	8755	0.0	2	8312 383 60
27	8394	0.0	2	7972 369 53
28	7899	0.0	2	7493 352 53 1
29	7229	0.0	2	6811 352 60 6
30	6751	0.0	3	6378 300 46 27
31	6415	0.0	3	5997 352 52 14
32	5747	0.0	3	5426 254 46 21
33	5477	0.0	3	5128 286 45 18
34	5129	0.0	3	4818 251 47 13
35	4621	0.0	3	4362 204 38 17
36	4527	0.0	3	4260 214 30 23
37	4073	0.0	3	3801 221 30 21
38	3818	0.0	3	3595 183 24 16
39	3496	0.0	3	3295 165 22 14
40	3100	0.0	3	2931 137 18 14
41	2856	0.0	3	2688 137 18 13
42	2500	0.0	3	2333 130 25 12
43	2232	0.0	3	2093 116 13 10
44	1998	0.0	3	1902 75 9 12
45	1872	0.0	3	1755 101 8 8
46	1692	0.0	3	1580 84 14 14
47	1375	0.0	3	1293 60 16 6
48	1309	0.0	3	1223 68 10 8
49	1244	0.0	3	1142 79 14 9
50	1065	0.0	3	997 54 4 10
51	935	0.0	3	868 55 5 7
52	889	0.0	3	828 45 8 8
53	739	0.0	3	678 42 17 2
54	667	0.0	3	620 37 4 6
55	629	0.0	3	584 35 6 4
56	537	0.0	3	508 21 4 4
57	445	0.0	3	407 27 7 4
58	444	0.0	3	414 18 9 3
59	408	0.0	3	373 18 8 9
60	366	0.0	3	335 20 3 8
61	302	0.0	3	278 17 6 1
62	276	0.0	3	245 23 8
63	236	0.0	3	222 10 3 1
64	233	0.0	3	213 16 3 1
65	213	0.0	3	192 16 4 1
66	198	0.0	3	184 13 1
67	158	0.0	3	138 13 4 3
68	166	0.0	3	145 14 3 4
69	115	0.0	3	104 5 3 3
70	115	0.0	3	99 9 4 3
71	103	0.0	3	92 9 1 1
72	90	0.0	3	73 8 8 1
73	70	0.0	3	58 10 1 1
74	64	0.0	3	51 6 4 3
75	56	0.0	3	49 5 2
76	55	0.0	3	44 7 3 1
77	54	0.0	3	47 3 2 2
78	45	0.0	3	39 3 1 2
79	42	0.0	3	33 5 2 2
80	41	0.0	3	32 6 1 2
81	42	0.0	3	40 0 2
82	32	0.0	3	26 5 1
83	81	0.0	3	77 3 1
84	32	0.0	3	29 3
85	57	0.0	3	48 5 3 1
86	30	0.0	3	25 4 0 1
87	39	0.0	3	33 3 2 1
88	22	0.0	3	16 4 2
89	31	0.0	3	28 3
90	25	0.0	3	20 3 1 1
91	30	0.0	3	29 1
92	15	0.0	3	11 4
93	27	0.0	3	21 4 1 1
94	13	0.0	3	9 4
95	27	0.0	3	13 10 3 1
96	41	0.0	3	15 21 2 3
97	20	0.0	3	14 6
98	21	0.0	3	7 9 4 1
99	11	0.0	3	3 5 2 1
100	14	0.0	3	0 7 7
101	9853	0.0	3	13 8738 1011 91

Next step is Trimmomatic:
http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf 

java -jar <path to trimmomatic.jar> PE [-threads <threads] [-phred33 | -phred64] [-trimlog <logFile>] >] [-basein <inputBase> | <input 1> <input 2>] [-baseout <outputBase> | <unpaired output 1> <paired output 2> <unpaired output 2> <step 1>

java -jar trimmomatic-0.39.jar 

Using this manual for trimmomatic for paired-end reads.

* LEADING: quality of 3
* TRAILING: quality of 3
* SLIDING WINDOW: window size of 5 and required quality of 15
* MINLENGTH: 35 bases

ILLUMINACLIP:<fastaWithAdaptersEtc>:<seed mismatches>:<palindrome clip threshold>:<simple clip threshold>:<minAdapterLength>

ILLUMINACLIP:TruSeq3-PE.fa:2:30:10:2:True <not necessary; consulted Pete) Also don’t need the java jar because we already have trimmomatic downloaded.

trimmomatic PE /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_trimmed_out.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:25

Output:

Quality encoding detected as phred33
Input Read Pairs: 12428766 Both Surviving: 11926217 (95.96%) Forward Only Surviving: 487688 (3.92%) Reverse Only Surviving: 2524 (0.02%) Dropped: 12337 (0.10%)
TrimmomaticPE: Completed successfully

trimmomatic PE /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_trimmed_out.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:25

Output: 

Quality encoding detected as phred33
Input Read Pairs: 6873509 Both Surviving: 6547575 (95.26%) Forward Only Surviving: 323456 (4.71%) Reverse Only Surviving: 1277 (0.02%) Dropped: 1201 (0.02%)
TrimmomaticPE: Completed successfully

Have to plot the graphs of read 1 and read 2 on the same plot. Doing this in R markdown. File is QAA_pt2_plots.Rmd 


I realized I added 25 for minlen instead of 35. Rerunning. These are the actual outputs:

QAA2) [evew@n0191 QAA]$ trimmomatic PE /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_trimmed_out.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35
TrimmomaticPE: Started with arguments:
 /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_trimmed_out.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35
Quality encoding detected as phred33
Input Read Pairs: 12428766 Both Surviving: 11724970 (94.34%) Forward Only Surviving: 678079 (5.46%) Reverse Only Surviving: 8730 (0.07%) Dropped: 16987 (0.14%)
TrimmomaticPE: Completed successfully

(QAA2) [evew@n0191 QAA]$ trimmomatic PE /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_trimmed_out.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35
TrimmomaticPE: Started with arguments:
 /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_trimmed_out.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35
Quality encoding detected as phred33
Input Read Pairs: 6873509 Both Surviving: 6427611 (93.51%) Forward Only Surviving: 437216 (6.36%) Reverse Only Surviving: 4652 (0.07%) Dropped: 4030 (0.06%)
TrimmomaticPE: Completed successfully


Dictionary for QAA pt 2 plot: length of sequences and see how many counts are associated

Talapas very slow.
Wrote a bash script and python script.

Plotting is giving problems. Had Temi take a look. Looks okay to her, but got rid of subplot extra figure dimensions and just left it as subplot(1,2)

Misspelled: changed to suptitle instead of subtitle :’)

2023_09_11
Part 3:
Mus_musculus.GRCm39.dna.primary_assembly.fa.gz From Ensemble 
https://ftp.ensembl.org/pub/release-110/fasta/mus_musculus/dna/

GTF:
Mus_musculus.GRCm39.110.gtf.gz
https://ftp.ensembl.org/pub/release-110/gtf/mus_musculus/

Add to sbatch or srun
-p interactive
—reservation=bgmp-res

In order to reserve a node for later usage, use this s-run command:
srun --account=bgmp --partition=interactive --mem=16G --reservation=bgmp-res --time=3:00:00 --pty bash 
With help from Eden and Leslie 
Copied over PS8 scripts and then replaced it with the path files for the mus musculus.

Ran QAA_STAR.sh

(Currently in queue)

Next will have to run QAA_STAR_align to make the reference genome.

After need to run PS8 python script to get mapped and unmapped reads. 

After running scripts, outputted these two SAM files:

QAA_new_28_4D_mbnl_S20_L008_Aligned.out.sam
QAA_new_3_2B_control_S3_L008_Aligned.out.sam 

However, checking slurs file, I get this warning:
EXITING because of FATAL ERROR in reads input: quality string length is not equal to sequence length
slurm-56059.out

Referred to Tam and she mentioned that I was expected to get four total output files from trimmomatic with paired and unpaired spelled out. 

Had to rerun trimmomatic. Instead of running it on terminal, made a wrapper instead. 

/usr/bin/time trimmomatic PE /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_paired_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001__unpaired_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_paired_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_unpaired_trimmed_out.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35

/usr/bin/time trimmomatic PE /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_paired_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_unpaired_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_paired_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_unpaired_trimmed_out.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35

Reran plot script. This time it works. Added a prefix to suptitle.

Reran STAR_align script but with corrected output files for paired of both reads. 
Sam files look okay. Slurm also looks okay. Under demultiplex_output/slurm_files: see slurm-56506.out 

	STAR --runThreadN 8 --runMode alignReads --outFilterMultimapNmax 3 --outSAMunmapped Within KeepPairs --alignIntronMax 1000000 --alignMatesGapMax 1000000 --readFilesIn /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_paired_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_paired_trimmed_out.fastq --genomeDir /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR/ --outFileNamePrefix /projects/bgmp/evew/bioinfo/QAA/STAR/Mouse_QAA_new_28_4D_mbnl_S20_L008_
	STAR version: 2.7.10b   compiled: 2022-11-01T09:53:26-04:00 :/home/dobin/data/STAR/STARcode/STAR.master/source
Sep 11 21:24:04 ..... started STAR run
Sep 11 21:24:04 ..... loading genome
Sep 11 21:24:30 ..... started mapping
Sep 11 21:25:47 ..... finished mapping
Sep 11 21:25:48 ..... finished successfully

	Command being timed: "STAR --runThreadN 8 --runMode alignReads --outFilterMultimapNmax 3 --outSAMunmapped Within KeepPairs --alignIntronMax 1000000 --alignMatesGapMax 1000000 --readFilesIn /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001_paired_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001_paired_trimmed_out.fastq --genomeDir /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR/ --outFileNamePrefix /projects/bgmp/evew/bioinfo/QAA/STAR/Mouse_QAA_new_28_4D_mbnl_S20_L008_"
	User time (seconds): 590.26
	System time (seconds): 10.28
	Percent of CPU this job got: 581%
	STAR --runThreadN 8 --runMode alignReads --outFilterMultimapNmax 3 --outSAMunmapped Within KeepPairs --alignIntronMax 1000000 --alignMatesGapMax 1000000 --readFilesIn /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001_paired_trimmed_out.fastq /projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001_paired_trimmed_out.fastq --genomeDir /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR/ --outFileNamePrefix /projects/bgmp/evew/bioinfo/QAA/STAR/Mouse_QAA_new_3_2B_control_S3_L008_
	STAR version: 2.7.10b   compiled: 2022-11-01T09:53:26-04:00 :/home/dobin/data/STAR/STARcode/STAR.master/source
Sep 11 21:25:48 ..... started STAR run
Sep 11 21:25:48 ..... loading genome
Sep 11 21:26:03 ..... started mapping
Sep 11 21:26:47 ..... finished mapping
Sep 11 21:26:47 ..... finished successfully

Now have proper SAM files:
(base) [evew@n0198 STAR]$ cd /projects/bgmp/evew/bioinfo/QAA/STAR/
(base) [evew@n0198 STAR]$ ls
Mouse_QAA_new_28_4D_mbnl_S20_L008_Aligned.out.sam   Mouse_QAA_new_28_4D_mbnl_S20_L008_SJ.out.tab        Mouse_QAA_new_3_2B_control_S3_L008_Log.progress.out
Mouse_QAA_new_28_4D_mbnl_S20_L008_Log.final.out     Mouse_QAA_new_3_2B_control_S3_L008_Aligned.out.sam  Mouse_QAA_new_3_2B_control_S3_L008_SJ.out.tab
Mouse_QAA_new_28_4D_mbnl_S20_L008_Log.out           Mouse_QAA_new_3_2B_control_S3_L008_Log.final.out
Mouse_QAA_new_28_4D_mbnl_S20_L008_Log.progress.out  Mouse_QAA_new_3_2B_control_S3_L008_Log.out

Two SAM files for PS8 script

Mouse_QAA_new_28_4D_mbnl_S20_L008_Aligned.out.sam

Ran Mouse_QAA_STAR_parser.sh which is my batch script for accessing PS8 script for mapped and unmapped reads: (see /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR_out/slurm-56523.out)

Number of mapped reads: 22657634
Number of unmapped reads: 793166 

Mouse_QAA_new_3_2B_control_S3_L008_Aligned.out.sam 

Ran Mouse_QAA_STAR_parser.sh which is my batch script for accessing PS8 script for mapped and unmapped reads:

Number of mapped reads: 12359959
Number of unmapped reads: 496079

Running htseq
Made a separate htseq folder 

For script, using this as reference: https://htseq.readthedocs.io/en/latest/htseqcount.html#htseqcount

Conda activate QAA2

/usr/bin/time htseq-count --stranded=yes /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR_out/Mouse_QAA_new_28_4D_mbnl_S20_L008_Aligned.out.sam /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR/Mus_musculus.GRCm39.110.gtf  
/usr/bin/time htseq-count --stranded=reverse /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR_out/Mouse_QAA_new_28_4D_mbnl_S20_L008_Aligned.out.sam /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR/Mus_musculus.GRCm39.110.gtf 
/usr/bin/time htseq-count --stranded=yes /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR_out/Mouse_QAA_new_3_2B_control_S3_L008_Aligned.out.sam  /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR/Mus_musculus.GRCm39.110.gtf  
/usr/bin/time htseq-count --stranded=reverse /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR_out/Mouse_QAA_new_3_2B_control_S3_L008_Aligned.out.sam  /projects/bgmp/evew/bioinfo/Bi623/QAA/STAR/Mus_musculus.GRCm39.110.gtf 

Realized first run, I had misspelling for “reverse”
Those were not recorded on slurm
Rerunning again.

Stranded-yes, 28_4d

__no_feature	10337055
__ambiguous	8572
__too_low_aQual	22846
__not_aligned	384252
__alignment_not_unique	539378
875.51user 2.98system 14:40.77elapsed 99%CPU (0avgtext+0avgdata 171104maxresident)k
0inputs+0outputs (0major+397816minor)pagefaults 0swaps

Stranded-reverse, 28_4d

__no_feature	888880
__ambiguous	188817
__too_low_aQual	22846
__not_aligned	384252
__alignment_not_unique	539378
908.16user 2.96system 15:14.17elapsed 99%CPU (0avgtext+0avgdata 175980maxresident)k
0inputs+0outputs (0major+305431minor)pagefaults 0swaps

Stranded: yes, 3_2b

__no_feature	5645316
__ambiguous	5207
__too_low_aQual	15298
__not_aligned	239785
__alignment_not_unique	281880
503.75user 2.10system 8:27.85elapsed 99%CPU (0avgtext+0avgdata 171956maxresident)k
0inputs+0outputs (0major+296366minor)pagefaults 0swaps

Stranded-reverse, 3_2b

__no_feature	527458
__ambiguous	103113
__too_low_aQual	15298
__not_aligned	239785
__alignment_not_unique	281880
534.48user 2.28system 8:58.41elapsed 99%CPU (0avgtext+0avgdata 171776maxresident)k
0inputs+0outputs (0major+320851minor)pagefaults 0swaps

Adding > in batch file to output counts to separate txt folders instead of it being in SLURM

Made new directory for pt2 outputs. Moved STAR and STAR_out and trimmomatic.sh into folder. 

__09_12_2023__

Added files and folders to GitHub. 

Before answering the last question with ICA4, adding everything to R Md for report. Below are scp commands. 

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R1_001_fastqc/Images/adapter_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R1_001_fastqc/Images/duplication_levels.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R1_001_fastqc/Images/kmer_profiles.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R1_001_fastqc/Images/per_base_n_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R1_001_fastqc/Images/per_base_quality.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R1_001_fastqc/Images/per_base_sequence_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R1_001_fastqc/Images/per_sequence_gc_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R1_001_fastqc/Images/per_sequence_quality.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R1_001_fastqc/Images/per_tile_quality.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R1_001_fastqc/Images/sequence_length_distribution.png ./

—
scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R2_001_fastqc/Images/adapter_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R2_001_fastqc/Images/duplication_levels.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R2_001_fastqc/Images/kmer_profiles.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R2_001_fastqc/Images/per_base_n_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R2_001_fastqc/Images/per_base_quality.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R2_001_fastqc/Images/per_base_sequence_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R2_001_fastqc/Images/per_sequence_gc_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R2_001_fastqc/Images/per_sequence_quality.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R2_001_fastqc/Images/per_tile_quality.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/28_4D_mbnl_S20_L008_R2_001_fastqc/Images/sequence_length_distribution.png ./

—

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R1_001_fastqc/Images/adapter_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R1_001_fastqc/Images/duplication_levels.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R1_001_fastqc/Images/kmer_profiles.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R1_001_fastqc/Images/per_base_n_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R1_001_fastqc/Images/per_base_quality.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R1_001_fastqc/Images/per_base_sequence_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R1_001_fastqc/Images/per_sequence_gc_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R1_001_fastqc/Images/per_sequence_quality.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R1_001_fastqc/Images/per_tile_quality.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R1_001_fastqc/Images/sequence_length_distribution.png ./

—

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R2_001_fastqc/Images/adapter_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R2_001_fastqc/Images/duplication_levels.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R2_001_fastqc/Images/kmer_profiles.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R2_001_fastqc/Images/per_base_n_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R2_001_fastqc/Images/per_base_quality.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R2_001_fastqc/Images/per_base_sequence_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R2_001_fastqc/Images/per_sequence_gc_content.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R2_001_fastqc/Images/per_sequence_quality.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R2_001_fastqc/Images/per_tile_quality.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/3_2B_control_S3_L008_R2_001_fastqc/Images/sequence_length_distribution.png ./


—

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R1_001.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R12.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/28_4D_mbnl_S20_L008_R2_001.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R1_001.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R12.png ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/pt1_output/demultiplex_output/3_2B_control_S3_L008_R2_001.png ./

—

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/htseq/rev_stranded_Mouse_QAA_new_28_4D_mbnl_S20_L008_count.txt ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/htseq/rev_stranded_Mouse_QAA_new_3_2B_control_S3_L008_count.txt ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/htseq/stranded_Mouse_QAA_new_28_4D_mbnl_S20_L008_count.txt ./

scp evew@login.talapas.uoregon.edu:/projects/bgmp/evew/bioinfo/Bi623/QAA/htseq/stranded_Mouse_QAA_new_3_2B_control_S3_L008_count.txt ./


Reusing ICA4 commands to demonstrate whether the data are from strand-specific RNA-seq libraries

(base) [evew@n0198 htseq]$ cat stranded_Mouse_QAA_new_28_4D_mbnl_S20_L008_count.txt | grep -v "__" | awk ' {sum+=$2} END {print sum}'
433297
(base) [evew@n0198 htseq]$ cat rev_stranded_Mouse_QAA_new_28_4D_mbnl_S20_L008_count.txt | grep -v "__" | awk ' {sum+=$2} END {print sum}'
9701227
(base) [evew@n0198 htseq]$ cat rev_stranded_Mouse_QAA_new_28_4D_mbnl_S20_L008_count.txt | awk ' {sum+=$2} END {print sum}'
11725400
(base) [evew@n0198 htseq]$ cat stranded_Mouse_QAA_new_3_2B_control_S3_L008_count.txt | awk ' {sum+=$2} END {print sum}'
6428019
(base) [evew@n0198 htseq]$ cat rev_stranded_Mouse_QAA_new_3_2B_control_S3_L008_count.txt | awk ' {sum+=$2} END {print sum}'
6428019
(base) [evew@n0198 htseq]$ cat rev_stranded_Mouse_QAA_new_3_2B_control_S3_L008_count.txt | grep -v "__" |awk ' {sum+=$2} END {print sum}'
5260485
(base) [evew@n0198 htseq]$ cat stranded_Mouse_QAA_new_3_2B_control_S3_L008_count.txt | grep -v "__" | awk ' {sum+=$2} END {print sum}'
240533