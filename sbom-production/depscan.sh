#!/bin/bash


# Build the depscan docker image
docker build -t depscan ./dep-scan

# For each environment file in the env directory
for f in ./study-subjects-env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running depscan for  $filename"
  # Run the depscan docker image with the env file as an argument
  container_ID="$(docker run --env-file ./study-subjects-env/$filename.env  -d  -v maven-deps:/root/.m2 depscan)"
  docker wait $container_ID
  mkdir -p ./results/$filename/depscan
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/$filename/"
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/reports/sbom-java.json ./results/$filename/depscan/; 
done
