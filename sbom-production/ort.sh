#!/bin/bash
set -e

# Build the ort docker image
docker build -t ort ./ort

# For each environment file in the env directory
for f in ./study-subjects-env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running ort for  $filename"
  # Run the ort docker image with the env file as an argument
  container_ID="$(docker run --env-file ./study-subjects-env/$filename.env  -d -v maven-deps:/root/.m2 ort)"
  docker wait $container_ID
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/$filename/"
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/results/ort/analyzer-result.json ./results/$filename/ort/; 
done
