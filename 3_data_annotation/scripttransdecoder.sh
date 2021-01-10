#!/bin/bash

#ce script permet d'utiliser transdecoder pour identifier les transcrits correspondant à des ARNm via identification des ORFs
# Dossier par défaut, création (mkdir) du dossier results si il n'existe pas déjà (-p)
results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# création d'un dossier spécifique pour les résultats de ce script
results_transdecoder="transdecoder_results"
mkdir -p $results_transdecoder
cd $results_transdecoder

#Récupération des données nécessaire pour l'exécution de ce script
home_trinity="/ifb/data/mydatalocal/download/trinity"
trinity=${home_trinity}/"Trinity_RF.fasta"
trinity_map=${home_trinity}/"Trinity_RF.fasta.gene_trans_map"
echo "voici $trinity"
echo "voici $trinity_map"

#étape 1 : extraction des longs "cadres ouverts de lecture" (ORFs)des transcrits
#-t donne le fichier d'entrée, --gene_trans_map donne le fichier donnant la correspondance gène/transcrit
#-S indique qu'on travail de manière brin-spécifique
#-O indique le dossier de sortie
TransDecoder.LongOrfs -t $trinity --gene_trans_map $trinity_map -S -O ${results}/${results_transdecoder}

#étape 2 prediction des régions codantes probables
#-t idem
#--single_best_only indique qu'on ne garde pour chaque transcrit que l'orf le plus long dans notre cas
#-O idem
TransDecoder.Predict -t $trinity --single_best_only -O ${results}/${results_transdecoder}
echo 'the end!'