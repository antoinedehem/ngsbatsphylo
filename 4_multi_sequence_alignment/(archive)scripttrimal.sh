#!/bin/bash

results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# créer un dossier spécifique
results_trimal="phyml_trimal"
mkdir -p $results_trimal
cd $results_trimal

trimal -in $results/prank_results/ -out "output_file" -phylip "output file in PHYLIP format"