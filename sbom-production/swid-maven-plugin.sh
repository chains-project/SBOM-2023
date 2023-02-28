#!/bin/bash
set -e

# Build the swid-maven-plugin docker image
docker build -t swid-maven-plugin ./swid-maven-plugin

# For each environment file in the env directory
for f in ./study-subjects-env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running swid-maven-plugin for  $filename"
  # Run the swid-maven-plugin docker image with the env file as an argument
  container_ID="$(docker run --env-file ./study-subjects-env/$filename.env  -d -v maven-deps:/root/.m2 swid-maven-plugin)"
  docker wait $container_ID
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/$filename/"
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/target/site/ ./results/$filename/swid-maven-plugin/; 
done
