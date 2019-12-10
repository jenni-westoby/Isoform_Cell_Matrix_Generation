#!/bin/bash
./setup.sh
../temp/fastqs/wrapper.sh
python ./generate.py Kallisto `pwd` ../temp/results
./Kallisto_Counts.sh
sed 's|"../temp/results/||g' Kallisto_Counts.txt | sed 's|/abundance.tsv"||g' | sed 's/|.*"//g' | sed 's/"//g' | sed "s/_1.fastq//g" > bulk_downsampled_counts.txt
Rscript downsampling.R
