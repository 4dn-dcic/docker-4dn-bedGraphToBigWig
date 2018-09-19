#!/bin/bash

# Runs bedtobigwig. Converts a bedgraph file into a bigwig file.

INPUT=$1
CHROMESIZE=$2
OUTDIR=$3

gunzip $INPUT.bedGraph.gz 
bedGraphToBigWig $INPUT.bedGraph $CHROMESIZE $OUTDIR/$INPUT.bw
