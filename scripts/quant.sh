#!/bin/bash

input_arr=("$@")
cd sras

for i in "${input_arr[@]}"
do
  #wget url
  wget -t 100 $i
  
  #extract string from url
  filename=`echo $i | awk -F/ '{print $11}'`
  
  #extract fastqs
   ../software/sratoolkit.2.9.0-ubuntu64/bin/fastq-dump --split-3 $filename".sra"
    
  #Kallisto quantification 
  ../software/kallisto quant -i ../index/transcripts.idx --threads=8 --output-dir=../results $filename'_1.fq' $filename'_2.fq'
  
  #Delete everything except Kallisto results
  rm $filename*
  
done
