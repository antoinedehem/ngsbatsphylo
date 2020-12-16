#!/bin/bash

echo "usage: ./scriptprank.sh gene_name numéro_fichier"

results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# créer un dossier spécifique
results_prank="prank_results"
mkdir -p $results_prank
cd $results_prank

gene=$1 #number=$2
#fasta=/ifb/data/mydatalocal/results/blast_results/"${gene}+Myovel${number}.fasta"
fasta=`ls $results/blast_results/$gene"+"*"fasta"`
echo "voici le fichier" $fasta
prank -d=$fasta -gaprate=0.5  -gapext=0.005 -o="${gene}+Myovel_prank"
prank -d=$fasta -gaprate=0.005  -gapext=0.5 -o="${gene}+Myovel_prank2"
# créer un dossier spécifique
results_trimal="phyml_trimal"
mkdir -p $results_trimal
cd $results_trimal

trimal -in $results/prank_results/"${gene}+Myovel_prank.*" -out ""${gene}+Myovel_trimal"" -phylip
trimal -in $results/prank_results/"${gene}+Myovel_prank2.*" -out ""${gene}+Myovel_trimal"" -phylip
