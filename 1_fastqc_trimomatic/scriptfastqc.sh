#!/bin/bash

# Dossier par défaut

results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# créer un dossier spécifique
results_fastqc="fastqc_results"
mkdir -p $results_fastqc
cd $results_fastqc

#Récupération des données

home_fastq="/ifb/data/mydatalocal/download/FASTQ/"
fastq=$home_fastq/"*.gz"

#vériication de fastq
fastqc -o /ifb/data/mydatalocal/results /ifb/data/mydatalocal/download/FASTQ/Lib1_31_20_S1_R1_001.fastq.gz
#boucle d'analyse
for fichier in $fastq
do
echo "voici $fichier"
fastqc $fichier -o $results/results_fastqc 
done
