###TP bats NGS

read me du projet NGS chauve souris

ceci est un rajout en J1 pour tester le push

##J1 : Découverte de bash et construction d'un script fastqc

  Après tutoriels sur bash les fichiers ont été téléchargés sur le VM (Virtual Machine).
Les fichiers ont été rangés plus près de la racine pour simplifier les chemins
On se retouve donc avec les données de RNAseq brutes

  Avant de commencer à les assembler il convient de vérifier la qualité des données
On réalise donc un test de la qualité via le logiciel fastqc (voir le script dans 1_fastqc_trimomatic/scriptfastqc.sh)
Le logiciel a été lancé sur la nuit

##J2 : Résultats fastqc brutes et Trimmomatic

  Les résutats du fastqc ont été passés en revue, les principaux soucis sont : séquence de l'adaptateur pollue les données, 5 premiers nucléotides des fragments sont potentiellement riches en erreurs, on veut supprimer les séquences trop courtes
  
  On prépare donc un script trimmomatic permettant de résoudre ces soucis en nettoyant les données. Ce logiciel créé de nouveaux fichiers fastq nettoyés. Les paramètres choisis ont été : HEADCROP=5 (5 premiers nucléotides des séquences supprimés)/ILLUMINACLIP=adapt.fasta (on supprime les parties de séquence trop similaire à l'adaptateur compris dans adapt.fasta)/MINLEN=100 (on supprime les séquences de moins de 100 nucléotides) (voir le script scripttrimomatic.sh dans 1_fastqc_trimomatic)
On laisse tourner Trimmomatic sur la nuit

##J3 Fastqc des données nettoyées et Trinity

  Les données obtenues par Trimmomatic sont réparties en paired et unpaired, seules les paired nous intéressent.
On a passé les fichiers obtenus dans fastqc pour vérifier si on a bien nettoyer les données : le problème de l'adaptateur a été nettoyé/ le problème de qualité des premiers nucléotides également, émergence d'une plus grande proportion de séquences dupliquées. Le nettoyage semble donc satisfaisant. (voir le script scriptfastqcclean.sh dans 1_fastqc_trimomatic)

  Trinity : attention FR-firststrand est inversé en RF pour SS_lib_type 
Préparation d'un script Trinity pour l'assemblage des fichiers des librairies. On construit donc des listes pour les Read 1 et pour les R2 qu'on donne à manger à Trinity. (voir le script scripttrinity.sh dans 2_assembly) 

  nohup :permet de lancer un script sans bloquer le terminal et de permettre aux scripts de s'exécuter en autonomie sur la VM,  tuto pour l'utiliser exemple "nohup ./scripttrinity.sh >& nohup.trinity.txt &" pour voir ce qu'on a lancé "ps" pour arrêter un script "kill "numéro du script"" pour voir où en est le script "tail nomdufichiertextnohup" pour arrêter la commande less appuyer sur la touche "q"
  
##J4 BLAST, Transdecoder
But de Transdecoder: analyse les données assemblées par trinity pour trouver les séquences codantes. Réalisation d'un script analysant les données avec Transcoder (voir le script scripttranscoder.sh dans 3_data_annotation). On utilise l'option single_best_only qui permet de ne garder que les plus longs ORFs pour chaque fragment d'ARNm.

But de BLAST: trouve des alignements locaux entre une séquence de référence et une séquence d'intérêt
On va par exemple blaster nos données Trinity avec des séquences de références PKR (une famille d'ISGs) d'une espèce connue: Myotis lucifugus (espèce la plus proche) ou Homo Sapiens (espèce la mieux annotée). On choisit l'approche la plus simple : Homo Sapiens. (voir le scriptblast.sh dans 3_data_annotation)