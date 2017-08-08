#!/bin/bash
cd "$( cd "$( dirname "$0" )" && pwd )/.."

# First parameter: benchmark config name (folder inside scripts/configs)
CPS_BENCHMARK=$1
# Second parameter: result identifier
CPS_RESULT_ID=$2

if [ -z ${WORKSPACE}]; then
  WORKSPACE="."
fi

if [ $CPS_RESULT_ID = "latest" ]; then
  resultsInConfig=( ${WORKSPACE}/$1/* )
  CPS_RESULT_ID=$(basename ${resultsInConfig[-1]})
fi

rm -rf diagrams
mkdir diagrams
python3 ${WORKSPACE}/mondo-sam/reporting/report.py --source ${WORKSPACE}/$1/$2/results.csv \
--output ${WORKSPACE}/diagrams/ --config ${WORKSPACE}/$1/config.json
