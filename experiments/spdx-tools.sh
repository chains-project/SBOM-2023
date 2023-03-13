#!/bin/bash
set -e

# Build the spdx-tools docker image
docker build -t spdx-tools ./spdx-tools

# For each environment file in the env directory
for f in ./env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running spdx-tools for  $filename"
  # Run the spdx-tools docker image with the env file as an argument
  container_ID="$(docker run --env-file ./env/$filename.env  -d -v maven-deps:/root/.m2 spdx-tools)"
  docker wait $container_ID
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/$filename/spdx-tools"
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/results_veri/ ./results/$filename/spdx-tools/; 
done
