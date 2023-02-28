#bin/bash

# Generate all SBOMs
cd  ./sbom-production && bash ./generateAll.sh && cd ..

# Generate ground truth
cd ./ground-truth-production && bash ./generateGroundTruth.sh && cd ..

# Compute the metrics

## Combine the ground truth and the SBOMs into a single directory

mkdir -p results-march-2023

cp -r sbom-production/results/* results-march-2023/
cp -r ground-truth-production/results/* results-march-2023/

## Run the metrics

cd metrics-computation&& mvn clean package && java -jar target/metrics-computation-1.0.0-SNAPSHOT.jar ../results-march-2023/ && cd ..
# The SBOM diff are now in results-march-2023/metrics/sbom-diffs
# Write the results of all run into results-march-2023/metrics/runResult.csv
mkdir -p your-results
cp -r metrics-computation/*.csv your-results 
expectedFailureCount=$(grep -c "0,0,0,0,0,0" results-march-2023/metrics/runResult.csv)
# ToDo: maybe print tool names that failed
actualFailureCount=$(grep -c "0,0,0,0,0,0" your-results/resultsTreeAll.csv)

echo "Checking for count of failure runs"
if [ $expectedFailureCount -eq $actualFailureCount ]; then
  echo "All expected failures occured"
else
  echo "Not all expected failures occured ($expectedFailureCount expected, $actualFailureCount actual)"
  exit 1
fi

diff -q expectedResults/metrics/graphData.csv results-march-2023/metrics/graphData.csv

if [ $? -eq 0 ]; then
  echo "Graph data is the same. The data corresponds to plot in the paper :)"
else
  echo "Graph data is different"
  exit 1
fi
