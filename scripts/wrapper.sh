#!/bin/bash

#if necessary set-up
./setup.sh

#Use beautiful soup to get urls
python scrape_urls.py $1

#Use Kallisto for quant
total=`wc -l urls.txt | awk '{print $1}'`
total=$(($total - 1))
IFS=$'\n' read -d '' -r -a lines < urls.txt

for i in `seq 0 10 $total`
do
  end=$(($i+9))
  
  #Need to add some bsub stuff here
   bsub -n8 -R"span[hosts=1]" -c 99999 -G team_hemberg -q normal -o $TEAM/temp.logs/output.kallisto_$i -e $TEAM/temp.logs/error.kallisto_$i -R"select[mem>100000] rusage[mem=100000]" -M100000 ./quant.sh ${lines[@]:$i:$end}
done

#make results matrices
python ./generate.py Kallisto `pwd` results
