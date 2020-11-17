#!/bin/bash

cleandata="/ifb/data/mydatalocal/cleandata"
mkdir -p $cleandata
cd $cleandata

home_download="/ifb/data/mydatalocal/download"
home_fastq=$home_download/"FASTQ"
fastq=$home_fastq/"*.gz"

for i in 1 2 3 4 5 6 
do
echo "Cleaning ${i}"
#appel du programme#paired end#le input#les output#les paramètres ILLUMINACLIP: Cut adapter and other illumina-specific sequences from the read. 
#HEADCROP: Cut the specified number of bases from the start of the read
#MINLEN: Drop the read if it is below a specified length
java -jar /softwares/Trimmomatic-0.39/trimmomatic-0.39.jar PE -phred33 $home_fastq/Lib${i}_31_20_S${i}_R1_001.fastq.gz $home_fastq/Lib${i}_31_20_S${i}_R2_001.fastq.gz Lib${i}_31_20_clean_paired_S${i}_R1.fq.gz Lib${i}_31_20_clean_unpaired_S${i}_R1.fq.gz Lib${i}_31_20_clean_paired_S${i}_R2.fq.gz Lib${i}_31_20_clean_unpaired_S${i}_R2.fq.gz ILLUMINACLIP:$home_download/adapt.fasta:2:30:10 HEADCROP:9 MINLEN:100
done
echo "the End!"