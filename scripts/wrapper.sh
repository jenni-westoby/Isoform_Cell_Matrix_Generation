#!/bin/bash

#if necessary set-up
#./setup.sh

#Use Kallisto for quant
total=`wc -l urls.txt | awk '{print $1}'`
total=$(($total - 1))
IFS=$'\n' read -d '' -r -a lines < urls.txt

for i in `seq 0 10 $total`
do

  #Need to add some bsub stuff here
   bsub -n8 -R"span[hosts=1]" -c 99999 -G team_hemberg -q normal -o $TEAM/temp.logs/output.kallisto_$i -e $TEAM/temp.logs/error.kallisto_$i -R"select[mem>10000] rusage[mem=10000]" -M10000 ./quant.sh ${lines[@]:$i:10}
done

#make results matrices
#python ./generate.py Kallisto `pwd` ../temp/results
