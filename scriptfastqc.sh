#!/bin/bash

#créer un dossier pour le fastQC

#cd mydatalocal

#mkdir results

#cd results

#mkdir fastqc

#cd ../..

#vériication de fastq
fastqc -o /ifb/data/mydatalocal/results /ifb/data/mydatalocal/download/FASTQ/Lib1_31_20_S1_R1_001.fastq.gz
#boucle d'analyse
for fichier in /ifb/data/mydatalocal/download/FASTQ/*.gz
do
echo "voici $fichier"
fastqc -o /ifb/data/mydatalocal/results/fastqc $fichier
done

#changer le outpout du fastqc
fastqc -o /ifb/data/mydatalocal/results/fastqc