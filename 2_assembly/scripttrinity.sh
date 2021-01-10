#!/bin/bash

#Ce script permet d'assembler les données de RNAseq nettoyées: on assemble donc les fichiers R1 avec les fichiers R2 correspondants.
# Dossier par défaut, création (mkdir) du dossier results si il n'existe pas déjà (-p)
results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# création d'un dossier spécifique pour les résultats de ce script
results_trinity="trinity_results"
mkdir -p $results_trinity
cd $results_trinity

#Récupération des données nécessaire pour l'exécution de ce script
home_fastqclean="/ifb/data/mydatalocal/cleandata"
#FQR1 comprend la liste des noms des fichiers R1, idem pour FQR2 et R2
FQR1=$(ls ${home_fastqclean}/Lib*_31_20_clean_paired*R1.fq.gz |paste -d "," -s)
FQR2=$(ls ${home_fastqclean}/Lib*_31_20_clean_paired*R2.fq.gz |paste -d "," -s)

#appelle le logiciel Trinity
#les fichiers d'entrée sont indiqués via --left et --right
#--output indique le dossier de sortie
#--seqtype peremt d'indiquer la nature des fichiers d'entrées donnés au logiciel (.fastq ici)
#--max_memory indiue la mémoire maximum mobilisable par le logiciel
#--CPU indique le nombre de coeur du CPU maximum mobilisable par le logiciel
#--SS_lib_type permet d'indiquer l'orientation des reads obtenus par RNAseq (dépend de la technique utilisée lors du séquencage)
Trinity --seqType fq --max_memory 8G --left $FQR1 --right $FQR2 --SS_lib_type RF --CPU 3 --output $results_trinity
echo 'The end!'