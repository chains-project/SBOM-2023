#!/bin/bash
# Build the cdxgen docker image
docker build -t cdxgen ./cdxgen
# For each file in the ./study-subjects-env/ directory
for f in ./study-subjects-env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print out the name of the filename
  echo "Running cdxgen for $filename"
  # Run the cdxgen docker image with the environment variables from ./study-subjects-env/$filename.env
  container_id="$(docker run  --env-file ./study-subjects-env/$filename.env  -d -v maven-deps:/root/.m2 cdxgen)"
  docker wait $container_id
  mkdir -p ./results/$filename/cdxgen
  # Copy the results from the docker container to ./results/$filename/bom.cdxgen.json
  docker cp $container_id:/$filename/bom.cdxgen.json ./results/$filename/cdxgen/; 
done