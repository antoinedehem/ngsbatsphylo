#!/bin/bash

cleaneddata="/ifb/data/mydatalocal/cleaneddata"
mkdir -p $cleaneddata
cd $cleaneddata

home_download="/ifb/data/mydatalocal/download"
home_fastq=$home_download/"FASTQ"
fastq=$home_fastq/"*.gz"

for i in 1 2 3 4 5 6 
do
#appel du programme
java -jar /softwares/Trimmomatic-0.39/trimmomatic-0.39.jar\
#paired end
PE -phred33\
#le input
$home_fastq/Lib1_31_20_S${i}_R1_001 $home_fastq/Lib1_31_20_S${i}_R2_001\
#les output
cleaned_paired_S${i}_R1.fq.gz cleaned_unpaired_S${i}_R1.fq.gz\
cleaned_paired_S${i}_R2.fq.gz cleaned_unpaired_S${i}_R2.fq.gz\
#les paramètres illuminaclip: Cut adapter and other illumina-specific sequences from the read. 
#HEADCROP: Cut the specified number of bases from the start of the read
#MINLEN: Drop the read if it is below a specified length
ILLUMINACLIP:$home_download/adapt.fasta HEADCROP:5 MINLEN:100