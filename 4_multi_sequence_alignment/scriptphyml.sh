#!/bin/bash

results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# créer un dossier spécifique
results_phyml="phyml_results"
mkdir -p $results_phyml
cd $results_phyml


phyml -i "seq_file_name in PHYLIP format" -d "data-type : nt or aa" 

