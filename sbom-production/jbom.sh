#!/bin/bash


# Build the jbom docker image
docker build -t jbom ./jbom

# For each environment file in the env directory
for f in ./study-subjects-env/*; do 
(
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running jbom for $filename"
  # Run the build-info-go docker image with the env file as an argument
  container_ID="$(docker run --env-file ./study-subjects-env/$filename.env  -d  -v maven-deps:/root/.m2 jbom)"
  docker wait $container_ID
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/jbom/$filename/"
  mkdir -p ./results/$filename/jbom
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/jbom/jbom-..json ./results/$filename/jbom/; 
) &
done
wait
