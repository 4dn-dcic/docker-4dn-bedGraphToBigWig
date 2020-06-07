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

if  ! python /usr/local/bin/check_file_format.py pp.bedGraph $CHROMESIZE; then
    rm pp
    rm pp.bedGraph
    exit 1
fi

if grep -q "chrM" pp.bedGraph; then
  mkfifo pp2
  cat pp.bedGraph | awk '{if ($1 != "chrM") print}' > pp2.bedGraph
  bedGraphToBigWig pp2.bedGraph $CHROMESIZE $OUTDIR/$FILE_NAME.bw
  rm pp2
  rm pp2.bedGraph
  rm pp
  rm pp.bedGraph

else
  bedGraphToBigWig pp.bedGraph $CHROMESIZE $OUTDIR/$FILE_NAME.bw
  rm pp
  rm pp.bedGraph
fi
