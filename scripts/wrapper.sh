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
  ./quant.sh ${lines[@]:$i:$end}
done

#Need another script to make results matrices
