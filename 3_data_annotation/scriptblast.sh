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
  
  Transdecoder=$results"/transdecoder_results/Trinity_RF.fasta.transdecoder.cds"
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
    /softwares/ncbi-blast-2.10.1+/bin/blastn -db $Blastdb -query $QUERY -evalue 1e-20 -outfmt 6 -out $gene".blast" 
    fi ;
  ## dirty estimation Length of interest gene
  nchar=$(cat $QUERY | wc -c)
  echo "print nchar=" $nchar
  nseq=$(cat $QUERY | grep ">" -c)
  echo "print nseq=" $nseq
  lseq=$(echo "($nchar/$nseq)" | bc)

  echo "estimation of query length=" $lseq

  echo "selection of lines in BLAST output corresponding to alignement at least 50% of query length"
  target=$(echo $lseq/2 | bc)
  echo "That is" $target "bp"

  ###
  cat $blast | awk '{if($4>$target) {print $2 " " $4}}'
  
  homologs=$(cat $blast | awk '{if($4>'$target') {print $2}}' | sort | uniq)
  echo "sequence to retrieve:"
  echo $homologs
  homofile=$results"/"$results_blast"/"$gene".fasta"
  
  if [[ -s $homofile ]] ; then
  rn $homofile
  fi ;
  for seq in $homologs
    do
    /softwares/ncbi-blast-2.10.1+/bin/blastdbcmd -entry $seq -db $Blastdb -out tmp.fasta
    cat tmp.fasta >> $homofile
  done
  cat $QUERY $homofile > $results"/"$results_blast"/"$gene"+Myovel${target}.fasta"
else
  echo "bliiiiiip"
fi ;