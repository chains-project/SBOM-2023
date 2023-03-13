#!/bin/bash
# Build the scancode docker image
git clone https://github.com/nexB/scancode-toolkit
cd scancode-toolkit && docker build -t scancode .
rm -r scancode-toolkit

# For each file in the ./env/ directory
for f in ./env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print out the name of the filename
  echo "Running scancode for $filename"
  cat ./env/$filename.env | grep "RepoUrl" | cut -d "=" -f2 | xargs git clone
  # Run the scancode docker image with the environment variables from ./env/$filename.env
  container_id="$(docker run  -d -v $(pwd)/$filename:/$filename scancode -clpieu --json-pp $filename/bom.scancode.json /$filename)"
  # docker wait $container_id
  rm -r $filename
  mkdir -p ./results/$filename/scancode
  # Copy the results from the docker container to ./results/$filename/bom.scancode.json
  docker cp $container_id:/$filename/bom.scancode.json ./results/$filename/scancode/; 
done