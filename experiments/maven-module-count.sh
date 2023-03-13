#!/bin/bash

docker build -t maven-count-modules ./maven-count-modules

for f in ./env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running maven-count-modules for $filename"
  # Run the build-info-go docker image with the env file as an argument
  container_ID="$(docker run --env-file ./env/$filename.env  -d  -v maven-deps:/root/.m2 maven-count-modules)"
  docker wait $container_ID
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/$filename/maven-count-modules/"
  mkdir -p ./results/$filename/maven-count-modules
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/modules.json ./results/$filename/maven-count-modules/modules.json;
done
