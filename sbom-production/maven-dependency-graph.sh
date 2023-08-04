#!/bin/bash

docker build -t maven-dependency-graph ./maven-dependency-graph

for f in ./study-subjects-env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running maven-dependency-graph for $filename"
  # Run the build-info-go docker image with the env file as an argument
  container_ID="$(docker run --env-file ./study-subjects-env/$filename.env  -d  -v maven-deps:/root/.m2 maven-dependency-graph)"
  docker wait $container_ID
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/$filename/maven-dependency-graph/"
  mkdir -p ./results/$filename/maven-dependency-graph
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/target/graph.json ./results/$filename/maven-dependency-graph/graph.json;
done
