#!/bin/bash
#Ce script permet d'évaluer la qualité des données brutes de RNAseq via le logiciel fastqc 
# Dossier par défaut, création (mkdir) du dossier results si il n'existe pas déjà (-p)
results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# création d'un dossier spécifique pour les résultats de ce script
results_fastqc="fastqc_results"
mkdir -p $results_fastqc
cd $results_fastqc

#Récupération des données nécessaires pour utiliser le script. 
home_fastq="/ifb/data/mydatalocal/download/FASTQ/"
#*.gz permet de sélectionner tous les fichiers avec l'extension .gz
fastq=$home_fastq/"*.gz"

#boucle d'analyse, la boucle for permet d'éxecuter fastqc pour tous les fichiers dont les noms sont compris dans la variable fastq
#-o permet d'indiquer le dossier de sortie où seront écrits les fichiers de sortie de fastqc
for fichier in $fastq
do
echo "voici $fichier"
fastqc $fichier -o $results/results_fastqc 
done
