#!/bin/bash

# Dossier par défaut

results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# créer un dossier spécifique
results_trinity="trinity_results"
mkdir -p $results_trinity
cd $results_trinity

#Récupération des données

home_fastqclean="/ifb/data/mydatalocal/cleandata"
fastqclean=$home_fastqclean/"*.gz"

for i in 1 2 3 4 5 6 
do
echo 'Assembly number 1'
Trinity --seqType fq --max_memory 8G --left ${home_fastqcleanLib}/${i}_31_20_clean_paired_S${i}_R1.fq.gz --right ${home_fastqcleanLib}/Lib${i}_31_20_clean_paired_S${i}_R1.fq.gz --SS_lib_type RF --CPU 3 --output $results_trinity 
done
echo 'The end!'