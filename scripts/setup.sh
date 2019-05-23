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

#Install Kallisto
wget https://github.com/pachterlab/kallisto/releases/download/v0.43.1/kallisto_linux-v0.43.1.tar.gz
tar -xvzf kallisto_linux-v0.43.1.tar.gz
rm kallisto_linux-v0.43.1.tar.gz
if ! command -v ./kallisto_linux-v0.43.1/kallisto >/dev/null 2>&1; then
  echo "Failed to install Kallisto"
  exit 1
else
  echo "Successfully installed Kallisto"
fi

mkdir ../genome
cd ../genome

wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M20/gencode.vM20.transcripts.fa.gz
gunzip gencode.vM20.transcripts.fa.gz

mkdir ../index
cd ../index

../software/kallisto_linux-v0.43.1/kallisto index -i transcripts.idx ../genome/gencode.vM20.transcripts.fa
