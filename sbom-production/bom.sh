#!/bin/bash
set -e

# Build the bom docker image
docker build -t bom ./bom

# For each environment file in the env directory
for f in ./study-subjects-env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running bom for  $filename"
  # Run the bom docker image with the env file as an argument
  container_ID="$(docker run --env-file ./study-subjects-env/$filename.env  -d  -v maven-deps:/root/.m2 bom)"
  docker wait $container_ID
  mkdir -p ./results/$filename/bom
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/$filename/"
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/sbom.spdx.json ./results/$filename/bom/; 
done
