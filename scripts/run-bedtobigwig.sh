#!/bin/bash

# Aggregates a Bed file to a format compatible with higlass (beddb)

INPUT=$1
ASSEMBLY=$2
OUTDIR=$3

FILE_BASE=$(basename $INPUT)
FILE_NAME=${FILE_BASE%.*}
echo $FILE_NAME

mkfifo pp

if [ ! -d "$OUTDIR" ]
then
  mkdir $OUTDIR
fi

gunzip -c $INPUT > pp.bed

outputfile="$OUTDIR/$FILE_NAME.beddb"
echo $outputfile

clodius aggregate bedfile \
  --assembly $ASSEMBLY -o $outputfile \
   pp.bed

rm pp
rm pp.bed
