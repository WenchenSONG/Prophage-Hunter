# Prophage-Hunter
Prophage Hunter Linux Version
https://pro-hunter.genomics.cn/
## Background

Identifying active prophages is critical for studying coevolution of phage and bacteria, investigating phage physiology and biochemistry, and engineering designer phages for diverse applications. We present Prophage Hunter, a tool aimed at hunting for active prophages from whole genome assembly of bacteria. Combining sequence similarity-based matching and genetic features-based machine learning classification, we developed a novel scoring system that exhibits higher accuracy than current tools in predicting active prophages on the validation datasets. The option of skipping similarity matching is also available so that there's higher chance for novel phages to be discovered. Prophage Hunter provides a one-stop web service to extract prophage genomes from bacterial genomes, evaluate the activity of the prophages, identify phylogenetically related phages, and annotate the function of phage proteins.

## Install

System requirements: Linux

Software involved: blast, nterproscan, stringtie, Cufflinks, R-3.5, genemark (the latest version is sufficient, see software.list for details)
1. download and install the above softwares and update the absolute path to software.list
2. download database "steps" from https://drive.google.com/drive/folders/18FuMPNeXBmpeAVOOb1Vc9aQYgMTD0iRZ?usp=share_link
3. put folder "steps" under "all_script"
4. run sh generate.sh software.list to generate prophage_hunter_RUN.sh

## Usage

1. In the working directory, the default Input.fasta is specified as the input file, please rename the bacteria sequence to Input.fasta
Note: contig filters under 10k are not processed.

2. Run sh /"installation path"/prophage_hunter_RUN.sh in the current directory

3. As shown in the picture below
![image](https://user-images.githubusercontent.com/122762987/236393472-82576f87-0d44-4a4d-9971-2c1a43426ae5.png)

4. Results：.../Step8.Generating_final_outputs/01.Main_output.txt
![image](https://user-images.githubusercontent.com/122762987/236393765-4032b9f7-68a4-4342-9908-25c2fa7bac9b.png)

## Cite

Wenchen Song, Hai-Xi Sun, Carolyn Zhang, Li Cheng, Ye Peng, Ziqing Deng, Dan Wang, Yun Wang, Ming Hu, Wenen Liu, Huanming Yang, Yue Shen, Junhua Li, Lingchong You, Minfeng Xiao, Prophage Hunter: an integrative hunting tool for active prophages, Nucleic Acids Research, Volume 47, Issue W1, 02 July 2019, Pages W74–W80, https://doi.org/10.1093/nar/gkz380
