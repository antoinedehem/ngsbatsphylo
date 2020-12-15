#!/bin/bash

echo "usage: ./scriptblast.sh gene.name"

download="/ifb/data/mydatalocal/download"
results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# créer un dossier spécifique
results_blast="blast_results"
mkdir -p $results_blast
cd $results_blast

gene=$1
cd $download
QUERYDIR=$download/"all_aln/"
QUERY=$QUEDRYDIR/"$gene.fas"

if [ -e $QUERY ] ; then
  echo $QUERY "exists"
  
  Transdecoder=$results"/transdecoder_results/transdecoder_results/longest_orfs.cds"
  Blastdbdir=$download/"db/"
  Blastdb=$Blastdbdir/"Myotis_velifer_cds.db"
  db=$Blastdb.nhr
  mkdir -p $Blastdbdir
  
  if [[ -s $db ]] ; then
    echo $db "exists"
    else $db "is empty"