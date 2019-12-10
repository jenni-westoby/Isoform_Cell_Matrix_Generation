#!/usr/bin/env bash
seed=$RANDOM

file1="ERR_"$1"_1.fastq"
file2="ERR_"$1"_2.fastq"

./seqtk/seqtk sample -s$seed ERR522956_1.fastq 7000000 > $file1
./seqtk/seqtk sample -s$seed ERR522956_1.fastq 7000000 > $file2

echo $1
