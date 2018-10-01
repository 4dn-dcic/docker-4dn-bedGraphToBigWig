#!/bin/bash

# Runs bedtobigwig. Converts a bedgraph file into a bigwig file.

INPUT=$1
CHROMESIZE=$2
OUTDIR=$3

FILE_BASE=$(basename $INPUT)
FILE_NAME=${FILE_BASE%%.*}

mkfifo pp

if [ ! -d "$OUTDIR" ]
then 
 mkdir $OUTDIR
fi

gunzip -c $INPUT > pp.bedGraph
bedGraphToBigWig pp.bedGraph $CHROMESIZE $OUTDIR/$FILE_NAME.bw
rm pp
rm pp.bedGraph
