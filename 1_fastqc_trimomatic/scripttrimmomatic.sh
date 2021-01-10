#!/bin/bash
#Ce script permet de nettoyer les données brutes de RNAseq via le logiciel trimmomatic.

# création d'un dossier spécifique pour les résultats de ce script
cleandata="/ifb/data/mydatalocal/cleandata"
mkdir -p $cleandata
cd $cleandata

#Récupération des données nécessaires pour utiliser le script.
home_download="/ifb/data/mydatalocal/download"
home_fastq=$home_download/"FASTQ"
fastq=$home_fastq/"*.gz"

#boucle permettant d'exécuter trimmomatic sur tous les fichiers voulus
for i in 1 2 3 4 5 6 
do
echo "Cleaning ${i}"
#appel du programme
#nous avons des données en paired end-> PE
#les 2 premiers fichiers appelés sont les fichiers d'entrée à nettoyer, les 4 noms de fichiers suivants sont ceux des 4 fichiers de sortie: 2 paired pour le R1 et le R2 et 2 unpaired pour le R1 et le R2 
#les paramètres: ILLUMINACLIP: permet de donner une séquence de référence correspondant à la séquence de l'adaptateur illumina utilisé pour le séquencage et qu'il faut donc supprimer des données
#HEADCROP: permet de retirer un certain nombre de bases à partir du début de la séquence
#MINLEN: permet d'ignorer les séquences ayant une longeur inférieure au nombre donné
java -jar /softwares/Trimmomatic-0.39/trimmomatic-0.39.jar PE -phred33 $home_fastq/Lib${i}_31_20_S${i}_R1_001.fastq.gz $home_fastq/Lib${i}_31_20_S${i}_R2_001.fastq.gz Lib${i}_31_20_clean_paired_S${i}_R1.fq.gz Lib${i}_31_20_clean_unpaired_S${i}_R1.fq.gz Lib${i}_31_20_clean_paired_S${i}_R2.fq.gz Lib${i}_31_20_clean_unpaired_S${i}_R2.fq.gz ILLUMINACLIP:$home_download/adapt.fasta:2:30:10 HEADCROP:9 MINLEN:100
done
echo "the End!"