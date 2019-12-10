#!/bin/bash
    

  filename=`echo $1 | awk -F/ '{print $2}`

  #Kallisto quantification 
  ../software/kallisto quant -i ../index/transcripts.idx --threads=8 --output-dir=../results/$filename $filename'_1.fq' $filename'_2.fq' 

