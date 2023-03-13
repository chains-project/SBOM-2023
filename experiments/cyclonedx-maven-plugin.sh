#!/bin/bash
# Build the cyclonedx-maven-plugin docker image
docker build -t cyclonedx-maven-plugin ./cyclonedx-maven-plugin
# For each file in the ./env/ directory
for f in ./env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print out the name of the filename
  echo "Running cyclonedx-maven-plugin for $filename"
  # Run the cyclonedx-maven-plugin docker image with the environment variables from ./env/$filename.env
  container_id="$(docker run  --env-file ./env/$filename.env  -d -v maven-deps:/root/.m2 cyclonedx-maven-plugin)"
  docker wait $container_id
  mkdir -p ./results/$filename/cyclonedx-maven-plugin
  # Copy the results from the docker container to ./results/$filename/bom.cyclonedx-maven-plugin.json
  docker cp $container_id:/$filename/target/ ./results/$filename/cyclonedx-maven-plugin/; 
done
