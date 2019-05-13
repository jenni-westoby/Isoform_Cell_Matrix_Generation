#!/bin/bash

input_arr=("$@")
cd ../temp/sras

for i in "${input_arr[@]}"
do
  #wget url
  wget -t 100 $i
  
  #extract string from url
  filename=`echo $i | awk -F/ '{print $NF}'`
  
  #extract fastqs
   #../software/sratoolkit.2.9.0-ubuntu64/bin/fastq-dump --split-3 $filename".sra"
  gunzip $filename
  end=`echo $filename | awk -F_ '{print $2}'`
  filename=`echo $filename | awk -F_ '{print $1}'`

  if [ "$end" == "2.fastq.gz" ]; then
    
  	#Kallisto quantification 
  	../software/kallisto_linux-v0.43.1/kallisto quant -i ../index/transcripts.idx --threads=8 --output-dir=../results/$filename $filename'_1.fastq' $filename'_2.fastq'
  
  	#Delete everything except Kallisto results
  	rm $filename*
  fi
  
done
