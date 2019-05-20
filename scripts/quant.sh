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
  ../../software/salmon-latest_linux_x86_64/bin/salmon --no-version-check quant -i ../../index/transcripts.idx -l A --threads=8 -o ../../results/$filename -r $filename'.fastq'
  
  #Delete everything except Kallisto results
  #rm $filename*
  
done
