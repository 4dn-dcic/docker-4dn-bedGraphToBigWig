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
 echo "Directory does not exits!"
 mkdir $OUTDIR
fi

gunzip -c $INPUT > pp.bedGraph

if  ! python /usr/local/bin/checkBGformat_v3.py pp.bedGraph $CHROMESIZE; then
    rm pp
    rm pp.bedGraph
    exit 1
fi

bedGraphToBigWig pp.bedGraph $CHROMESIZE $OUTDIR/$FILE_NAME.bw

rm pp
rm pp.bedGraph
