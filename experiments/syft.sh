#!/bin/bash
set -e

# Build the syft docker image
docker build -t syft ./syft

# For each environment file in the env directory
for f in ./env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running syft for $filename"
  # Run the build-info-go docker image with the env file as an argument
  container_ID="$(docker run --env-file ./env/$filename.env  -d  -v maven-deps:/root/.m2 syft)"
  docker wait $container_ID
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/syft/$filename/"
  mkdir -p ./results/$filename/syft
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/sbom.json ./results/$filename/syft/; 
done
