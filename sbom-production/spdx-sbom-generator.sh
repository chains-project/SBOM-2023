#!/bin/bash
set -e

# Build the spdx-sbom-generator docker image
docker build -t spdx-sbom-generator ./spdx-sbom-generator

# For each environment file in the env directory
for f in ./study-subjects-env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running spdx-sbom-generator for  $filename"
  # Run the spdx-sbom-generator docker image with the env file as an argument
  container_ID="$(docker run --env-file ./study-subjects-env/$filename.env -d -v maven-deps:/root/.m2 spdx-sbom-generator)"
  docker wait $container_ID
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/$filename/"
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/target/site/ ./results/$filename/spdx-sbom-generator/; 
done
