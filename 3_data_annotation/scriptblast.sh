#!/bin/bash

echo "usage: ./scriptblast.sh gene_name"

download="/ifb/data/mydatalocal/download"
results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# créer un dossier spécifique
results_blast="blast_results"
mkdir -p $results_blast


gene=$1
cd $download
QUERYDIR=$download/"all_aln/"
QUERY=$QUERYDIR"$gene.fas"

if [ -e $QUERY ] ; then
  echo $QUERY "exists"
  
  Transdecoder=$results"/transdecoder_results/transdecoder_results/longest_orfs.cds"
  Blastdbdir=$download/"db/"
  Blastdb=$Blastdbdir"Myotis_velifer_cds.db"
  db=$Blastdb.nhr
  mkdir -p $Blastdbdir
  
  if [[ -s $db ]] ; then
    echo "$db exists"
    else 
    echo "$db is empty"
    /softwares/ncbi-blast-2.10.1+/bin/makeblastdb -in $Transdecoder -dbtype nucl -parse_seqids -out $Blastdb
    fi ;
  cd $results"/$results_blast"
  blast=$results"/$results_blast"/$gene".blast"
  echo $blast
  if [[ -s $blast ]] ; then
    echo "$blast exists"
    else
    echo "$blast is empty"
    /softwares/ncbi-blast-2.10.1+/bin/blastn -db $Blastdb -query $QUERY -evalue 1e-28 -outfmt 6 -out $gene".blast" 
    fi ;
else
echo "bliiiiiip"
fi ;