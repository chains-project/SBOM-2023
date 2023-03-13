#!/bin/bash
set -e

docker build -t maven-dependency-tree ./maven-dependency-tree

for f in ./env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print the env file name
  echo "Running maven-dependency-tree for $filename"
  # Run the build-info-go docker image with the env file as an argument
  container_ID="$(docker run --env-file ./env/$filename.env  -d  -v maven-deps:/root/.m2 maven-dependency-tree)"
  docker wait $container_ID
  # Print the docker container id
  echo "Copying results from docker container $container_ID to ./results/maven-dependency-tree/$filename/"
  mkdir -p ./results/$filename/maven-dependency-tree
  # Copy the results from the docker container to the results directory
  docker cp $container_ID:/$filename/tree.txt ./results/$filename/maven-dependency-tree/;
  ./maven-dependency-tree/dot-to-json.py ./results/$filename/maven-dependency-tree/tree.txt ./results/$filename/maven-dependency-tree/tree.json
  rm ./results/$filename/maven-dependency-tree/tree.txt
done
