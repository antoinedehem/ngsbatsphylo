 ### PARSE BLAST OUTPUT

  ## dirty estimation Length of interest gene
  nchar=cat $QUERY | wc -c
  nseq=cat $QUERY | grep ">" -c
  lseq=echo "($nchar/$nseq)" | bc

  echo "estimation of query length=" $lseq

  echo "selection of lines in BLAST output corresponding to alignement at least 50% of query length"
  target=echo $lseq/2 | bc
  echo "That it" $target "bp"

  ###
  cat $blast | awk '{if($4>$target) {print $2 " " $4}}'