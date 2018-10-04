set -e 
INPUT="input_file.json"
CHROMSIZE="chromsize.json"
CWD=$(pwd)
OUTDIR=$CWD/tests/test_outdir

../run-bedtobigwig.sh $INPUT $CHROMSIZE $OUTDIR

if [ -f "$OUTDIR/$INPUT.bw];
then
   echo "Output File exists."
   return 0;
else
   echo "Output File does not exists."
   return 1;
fi 


 
