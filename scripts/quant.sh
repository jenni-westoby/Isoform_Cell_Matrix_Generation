#!/bin/bash

input_arr=("$@")
cd ../temp/sras

for i in "${input_arr[@]}"
do
  #wget url
  ../software/sratoolkit.2.9.0-ubuntu64/bin/prefetch $i

  #extract string from url
  filename=`echo $i`

  cd sra
  #extract fastqs
   ../../software/sratoolkit.2.9.0-ubuntu64/bin/fastq-dump $filename".sra"

  #Kallisto quantification
  ../../software/kallisto_linux-v0.43.1/kallisto -i ../index/transcripts.idx --threads=8 --output-dir=../results --single $filename".fastq" -l 200 -s 30

  #Delete everything except Kallisto results
  rm $filename*

done
