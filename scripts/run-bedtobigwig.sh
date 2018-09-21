#!/bin/bash

# Runs bedtobigwig. Converts a bedgraph file into a bigwig file.

INPUT=$1
CHROMESIZE=$2
OUTDIR=$3

mkfifo pp.$k

gunzip -c $INPUT > pp.$k.bedGraph
bedGraphToBigWig pp.$k.bedGraph $CHROMESIZE $OUTDIR${INPUT%%.*}.bw
rm pp.$k
rm pp..bedGraph
