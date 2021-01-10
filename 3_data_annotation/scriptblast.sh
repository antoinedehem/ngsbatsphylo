#!/bin/bash
#Ce script permet d'utiliser le logiciel Blast pour reconnaître les régions codantes des transcrits identifiés par transdecoder
#cet echo permet d'indiquer à l'utilisateur.rice comment utiliser le script (en donnant le nom du gène voulu en variable)
echo "usage: ./scriptblast.sh gene_name"

# Dossier par défaut, création (mkdir) du dossier results si il n'existe pas déjà (-p)
download="/ifb/data/mydatalocal/download"
results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# création d'un dossier spécifique pour les résultats de ce script
results_blast="blast_results"
mkdir -p $results_blast

#$1 correspond à la variable données par l'utilisateur.rice lors de l'appel du script (et donc le nom du gène d'intérêt)
gene=$1
cd $download
#all_aln comprend les bases de données de référence des familles d'ISGs pour un éventail d'espèces de chauve-souris
QUERYDIR=$download/"all_aln/"
#Query correspond donc au fichier de la base de données de référence de la famille du gène d'intérêt 
QUERY=$QUERYDIR"$gene.fas"

#ce if vérifie que le fichier de référence existe bien
if [ -e $QUERY ] ; then
  echo $QUERY "exists"
  #Transdecoder correspond au fichier de sortie de transdecoder (transcrit des régions codantes probables)
  Transdecoder=$results"/transdecoder_results/Trinity_RF.fasta.transdecoder.cds"
  #création du dossier où va être écrit la bases de données de myotis velifer construite à partir des données issues de transdecoder 
  Blastdbdir=$download/"db/"
  Blastdb=$Blastdbdir"Myotis_velifer_cds.db"
  db=$Blastdb.nhr
  mkdir -p $Blastdbdir
  
  #ce if vérifie si la base de données a déjà été construite ou non 
  if [[ -s $db ]] ; then
    echo "$db exists"
    else 
    echo "$db is empty"
    #construction de la base de donnée de myotis velifer
    #-in est le fichier d'entrée (régions codantes du transcrit)
    #-dbtype est le type de base de donnée voulue, nucl correspond à une base de données de nucléotides
    #-out est le nom du fichier de sortie
    /softwares/ncbi-blast-2.10.1+/bin/makeblastdb -in $Transdecoder -dbtype nucl -parse_seqids -out $Blastdb
    fi ;
  cd $results"/$results_blast"
  blast=$results"/$results_blast"/$gene".blast"
  echo $blast
  #ce if permet de vérifier si le résultat du blast pour le gène d'intérêt existe déjà ou non
  if [[ -s $blast ]] ; then
    echo "$blast exists"
    else
    echo "$blast is empty"
    #blast stricto sensu
    #-db permet d'indiquer la base de données utilisée comme référence pour le blast, ici on utilise la base de données construites pour l'espèce mytois velifer à partir de nos données de transdecoder
    #-query correspond aux données blastées contre la base de donnée, ici on utilise les séquences de plusieurs espèces de chauve souris pour la famille de gènes d'intérêt
    #-out est le nom du fichier de sortie
    /softwares/ncbi-blast-2.10.1+/bin/blastn -db $Blastdb -query $QUERY -evalue 1e-20 -outfmt 6 -out $gene".blast" 
    fi ;
  ## estimation rapide de la longueur du gène d'intérêt en moyennant sur la base de données de référence pour plusieurs espèces de chauve souris
  #nchar est le nombre de caractères total de la base de données
  nchar=$(cat $QUERY | wc -c)
  echo "print nchar=" $nchar
  #nseq est le nombre de séquences du fichier
  nseq=$(cat $QUERY | grep ">" -c)
  echo "print nseq=" $nseq
  #lseq est donc la moyenne du nombre de caractère pour une séquence de la base de donnée, 
  lseq=$(echo "($nchar/$nseq)" | bc)

  echo "estimation of query length=" $lseq

#on cherche ici à ne garder que les séquences du fichier de sortie de blast qui ont un alignement au moins aussi longue que la moitié de la longueur moyenne du gène d'intérêt calculée précédemment
  echo "selection of lines in BLAST output corresponding to alignement at least 50% of query length"
  target=$(echo $lseq/2 | bc)
  echo "That is" $target "bp"

#construction du fichier regroupant les gènes homologues, pour la famille de gène d'intérêt, de myotis velifer et des autres espèces de chauve souris considérées
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