#!/bin/bash
    

echo $1

  #Kallisto quantification 
../software/kallisto_linux-v0.43.1/kallisto quant -i ../index/transcripts.idx --threads=8 --output-dir=../results/$1 $1 $1

