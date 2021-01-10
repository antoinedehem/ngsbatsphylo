#!/bin/bash
#ce script permet d'utiliser les logiciels prank, trimal et phyml

#1:utilisation du logiciel prank permettant de faire de l'alignement multi séquence grace au fichier obtenu via Blast
#cet echo permet d'indiquer à l'utilisateur.rice comment utiliser le script (en donnant le nom du gène voulu en  variable)
echo "usage: ./scriptprank.sh gene_name"

# Dossier par défaut, création (mkdir) du dossier results si il n'existe pas déjà (-p)
results="/ifb/data/mydatalocal/results"
mkdir -p $results
cd $results

# création d'un dossier spécifique pour les résultats de prank
results_prank="prank_results"
mkdir -p $results_prank
cd $results_prank

#gene correspond à la variable donnée par l'utilisateur.rice c'est à dire le nom de la famille de gènes d'intérêt
gene=$1
#fasta est le nom du fichier fasta du gèe d'intérêt obtenu via Blast
fasta=`ls $results/blast_results/$gene"+"*"fasta"`
echo "voici le fichier" $fasta
#on appelle le logiciel prank
#-d indique le fichier fasta utilisé en entrée
#-gaprate indique le degré de pénalisation de l'ouverture de gaps dans l'alignement
#-gapext indique le degré de pénalisation de l'extension des gaps dans l'alignement
#-o est le nom du fichier de sortie
prank -d=$fasta -gaprate=0.5  -gapext=0.005 -o="${gene}+Myovel_prank.0_5.0_005"
prank -d=$fasta -gaprate=0.005  -gapext=0.5 -o="${gene}+Myovel_prank.0_005.0_5"

#2: trimal permet de convertir le fichier de sortie de prank qui est en .fas en .phylip qui est le format de fichier utilisable par phyml
# création d'un dossier spécifique pour les résultats de trimal
cd $results
results_trimal="trimal_results"
mkdir -p $results_trimal
cd $results_trimal

#appel du logiciel trimal
#-in est le fichier d'entrée à convertir
#-out est le nom du fichier de sortie
#-phylip permet d'indiquer qu'on veut convertir le fichier d'entrée en fichier au format .phylip
trimal -in $results/prank_results/"${gene}+Myovel_prank.0_5.0_005.best.fas" -out "${gene}+Myovel_trimal.0_5.0_005.phy" -phylip
trimal -in $results/prank_results/"${gene}+Myovel_prank.0_005.0_5.best.fas" -out "${gene}+Myovel_trimal.0_005.0_5.phy" -phylip

#3:phyml, on utilise un logiciel permettant de construire un arbre phylogénétique à partir de données d'alignement multi-séquences au format .phylip
#cette construction d'arbre phylogénétique est réalisée via le modèle de maximum de vraisemblance
# création d'un dossier spécifique pour les résultats de phyml
results_phyml="phyml_results"
cd $results
mkdir -p $results_phyml
cd $results_trimal

#appel du logiciel phyml (l'appel est réalisé 2 fois car prank a été utilisé pour 2 ensembles de paramètres différents, cela permet d'évaluer si les paramètres gapext et gaprate de prank joue un rôle important dans l'alignement des séquences)
#-i est le fichier d'alignement d'entrée
#-d permet d'indiquer la nature des séquences considérées (nt=séquences nucléotidiques)
#-a modèle d'estimation du maximum de vraisemblance (e)
#-m indique le modèle de substitution utilisé (modèle HKY85 avec des probabilités pour les transversions et transitions spécifiques)
#-c
#-b nature du test statistique utilisé (approximate likelihood-ratio test ici=-1)
#-s modèle utilisé pour la construction de l'arbre (ici nearest neighbor exchange=NNI)
phyml -i $results/$results_trimal/"${gene}+Myovel_trimal.0_5.0_005.phy" -d  nt -a e -m HKY85 -c 4 -b -1 -s NNI
#les mv suivants permettent de déplacer les fichiers de sortie de phyml dans le dossier créé spécialement précédemment car phyml créé les fichiers dans le dossier du fichier d'entrée
mv $gene"+Myovel_trimal.0_5.0_005.phy_phyml_tree.txt" $results/phyml_results
mv $gene"+Myovel_trimal.0_5.0_005.phy_phyml_stats.txt" $results/phyml_results
phyml -i $results/$results_trimal/"${gene}+Myovel_trimal.0_005.0_5.phy" -d  nt -a e -m HKY85 -c 4 -b -1 -s NNI 
mv $gene"+Myovel_trimal.0_005.0_5.phy_phyml_tree.txt" $results/phyml_results
mv $gene"+Myovel_trimal.0_005.0_5.phy_phyml_stats.txt" $results/phyml_results