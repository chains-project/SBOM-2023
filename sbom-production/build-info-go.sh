#!/bin/bash


# Build the openrewrite docker image
docker build -t build-info-go ./build-info-go

# For each environment file in the env directory
for f in ./study-subjects-env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running build-info-go for  $filename"
  # Run the build-info-go docker image with the env file as an argument
  container_ID="$(docker run --env-file ./study-subjects-env/$filename.env  -d  -v maven-deps:/root/.m2 build-info-go)"
  docker wait $container_ID
  mkdir -p ./results/$filename/build-info-go
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/$filename/"
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/build-info-go.json ./results/$filename/build-info-go/build-info-go.json; 
done
