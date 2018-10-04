set -e 
INPUT="bedgrapthtobigwig-parta.input.json"
CHROMSIZE="bedgrapthtobigwig-parta.chromsize.json"
CWD=$(pwd)
OUTDIR=$CWD/tests/test_outdir

../../scripts/run-bedtobigwig.sh $INPUT $CHROMSIZE $OUTDIR

if [ -f "$OUTDIR/$INPUT.bw];
then
   echo "Output File exists."
   return 0;
else
   echo "Output File does not exists."
   return 1;
fi 


 
