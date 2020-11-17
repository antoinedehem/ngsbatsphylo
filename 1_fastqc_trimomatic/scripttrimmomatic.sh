#!/bin/bash

cleaneddata="/ifb/data/mydatalocal/cleaneddata"
mkdir -p $cleaneddata
cd $cleaneddata

home_trimmomatic="/ifb/data/mydatalocal/download/FASTQ/"
trimmomatic=$home_trimmomatic/"*.gz"
