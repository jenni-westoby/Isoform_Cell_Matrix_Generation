#!/bin/bash

mkdir ../temp
cd ../temp
mkdir results
mkdir software
mkdir sras
mkdir fastqs
cd software

#Downlaod sra toolkit
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.9.0/sratoolkit.2.9.0-ubuntu64.tar.gz
tar -xvzf sratoolkit.2.9.0-ubuntu64.tar.gz

#Install Salmon
wget https://github.com/COMBINE-lab/salmon/releases/download/v0.13.1/salmon-0.13.1_linux_x86_64.tar.gz
tar -xzvf salmon-0.13.1_linux_x86_64.tar.gz

mkdir ../genome
cd ../genome

wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M20/gencode.vM20.transcripts.fa.gz
gunzip gencode.vM20.transcripts.fa.gz

mkdir ../index
cd ../index

../software/salmon-latest_linux_x86_64/bin/salmon index -i transcripts.idx -t ../genome/gencode.vM20.transcripts.fa
