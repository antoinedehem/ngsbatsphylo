#!/bin/bash
#Ce script permet d'évaluer la qualité des données de RNAseq nettoyées via trimmomatic via le logiciel fastqc 
# Dossier par défaut, création (mkdir) du dossier results si il n'existe pas déjà (-p)
results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# création d'un dossier spécifique pour les résultats de ce script
results_fastqc="fastqc_results"
mkdir -p $results_fastqc
cd $results_fastqc

#Récupération des données nécessaire pour l'exécution de ce script
home_fastqclean="/ifb/data/mydatalocal/cleandata"
fastqclean=$home_fastqclean/"*.gz"

#boucle d'analyse, la boucle for permet d'éxecuter fastqc pour tous les fichiers dont les noms sont compris dans la variable fastqclean
#-o permet d'indiquer le dossier de sortie où seront écrits les fichiers de sortie de fastqc
for fichier in $fastqclean
do
echo "voici $fichier"
fastqc $fichier -o $results/fastqc_results 
done
