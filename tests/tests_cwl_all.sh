#!/bin/bash
set -e

CWL_NAME_LIST='bedgrapthtobigwig-parta'
for CWL_NAME in $CWL_NAME_LIST; do
  source tests/tests_cwl.sh $CWL_NAME;
done 

