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

home_fastqclean="/ifb/data/mydatalocal/cleandata"
fastqclean=$home_fastqclean/"*.gz"

#boucle d'analyse
for fichier in $fastqclean
do
echo "voici $fichier"
fastqc $fichier -o $results/fastqc_results 
done
