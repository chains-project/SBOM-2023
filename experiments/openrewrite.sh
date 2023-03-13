#!/bin/bash


# Build the openrewrite docker image
docker build -t openrewrite ./openrewrite

# For each environment file in the env directory
for f in ./env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running openrewrite for  $filename"
  # Run the openrewrite docker image with the env file as an argument
  container_ID="$(docker run --env-file ./env/$filename.env  -d -v maven-deps:/root/.m2 openrewrite)"
  docker wait $container_ID
  mkdir -p ./results/$filename/openrewrite
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/$filename/"
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/sbom.json ./results/$filename/openrewrite/; 
done
