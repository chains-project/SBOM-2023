#!/bin/bash
set -e

# Build the sbom-tool docker image
docker build -t sbom-tool ./sbom-tool

# For each environment file in the env directory
for f in ./study-subjects-env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running sbom-tool for  $filename"
  # Run the sbom-tool docker image with the env file as an argument
  container_ID="$(docker run --env-file ./study-subjects-env/$filename.env  -d -v maven-deps:/root/.m2/ sbom-tool)"
  docker wait $container_ID
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/$filename/"
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/_manifest ./results/$filename/sbom-tool/; 
done
