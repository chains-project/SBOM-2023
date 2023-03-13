#!/bin/bash
set -e

# Build the openrewrite docker image
docker build -t scanoss ./SCANOSS

# For each environment file in the env directory
for f in ./env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running scanoss for $filename"
  # Run the build-info-go docker image with the env file as an argument
  container_ID="$(docker run --env-file ./env/$filename.env  -d  -v maven-deps:/root/.m2 scanoss)"
  docker wait $container_ID
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/scanoss/$filename/"
  mkdir -p ./results/$filename/scanoss
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/sbom.json ./results/$filename/scanoss/; 
done
