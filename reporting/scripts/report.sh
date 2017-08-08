#!/bin/bash
cd "$( cd "$( dirname "$0" )" && pwd )/../.."

# First parameter: benchmark config name (folder inside scripts/configs)
CPS_BENCHMARK_CONFIG=$1
# Second parameter: result identifier
CPS_RESULT_ID=$2

if [ -z ${WORKSPACE} ]; then
  WORKSPACE="."
fi

if [ $CPS_RESULT_ID = "latest" ]; then
  resultsInConfig=( ${WORKSPACE}/$1/* )
  CPS_RESULT_ID=$(basename ${resultsInConfig[-1]})
fi

echo "Run reporting on $CPS_BENCHMARK_CONFIG/$CPS_RESULT_ID"

resultFile=${WORKSPACE}/$CPS_BENCHMARK_CONFIG/$CPS_RESULT_ID/results.csv
configFile=${WORKSPACE}/$CPS_BENCHMARK_CONFIG/$CPS_RESULT_ID/config.json

if [ ! -e configFile ]; then
  echo "Could not find specific config, using generic"
  configFile=${WORKSPACE}/reporting/configs/$CPS_BENCHMARK_CONFIG/config.json
fi

rm -rf diagrams
mkdir diagrams
python3 ${WORKSPACE}/mondo-sam/reporting/report.py --source $resultFile \
--output ${WORKSPACE}/diagrams/ --config $configFile
