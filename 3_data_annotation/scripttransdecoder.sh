#!/bin/bash

# Dossier par défaut

results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# créer un dossier spécifique
results_transdecoder="transdecoder_results"
mkdir -p $results_transdecoder
cd $results_transdecoder

#step 1 extract the long open reading frames
home_trinity="/ifb/data/mydatalocal/download/trinity"
trinity=${home_trinity}/"Trinity_RF.fasta"
trinity_map=${home_trinity}/"Trinity_RF.fasta.gene_trans_map"
echo "voici $trinity"
echo "voici $trinity_map"

TransDecoder.LongOrfs -t $trinity --gene_trans_map $trinity_map -S -O ${results}/${results_transdecoder}
#step 2 optional

#step 3 predict the likely coding regions
TransDecoder.Predict -t $trinity --single_best_only -O ${results}/${results_transdecoder}
echo 'the end!'