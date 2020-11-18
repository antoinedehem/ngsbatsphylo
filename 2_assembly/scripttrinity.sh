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
FQR1=$(ls ${home_fastqclean}/Lib*_31_20_clean_paired*R1.fq.gz |paste -d "," -s)
FQR2=$(ls ${home_fastqclean}/Lib*_31_20_clean_paired*R2.fq.gz |paste -d "," -s)


for i in 1 2 3 4 5 6 
do
echo 'Assembly number 1'
Trinity --seqType fq --max_memory 8G --left $FQR1 --right $FQR2 --SS_lib_type RF --CPU 3 --output $results_trinity 
done
echo 'The end!'