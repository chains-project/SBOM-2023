#!/bin/bash
# Build the scancode docker image
git clone https://github.com/nexB/scancode-toolkit
git checkout 52138807d064e270ad4cf5e606f4fd6f266853fa
cd scancode-toolkit && docker build -t scancode .
rm -r scancode-toolkit

# For each file in the ./study-subjects-env/ directory
for f in ./study-subjects-env/*; do 
  # Get the filename without the extension
  filename=$(basename "$f" .env)
  # Print out the name of the filename
  echo "Running scancode for $filename"
  cat ./study-subjects-env/$filename.env | grep "RepoUrl" | cut -d "=" -f2 | xargs git clone
  # Run the scancode docker image with the environment variables from ./study-subjects-env/$filename.env
  container_id="$(docker run  -d -v $(pwd)/$filename:/$filename scancode -clpieu --cyclonedx $filename/bom.scancode.json /$filename)"
  # docker wait $container_id
  rm -r $filename
  mkdir -p ./results/$filename/scancode
  # Copy the results from the docker container to ./results/$filename/bom.scancode.json
  docker cp $container_id:/$filename/bom.scancode.json ./results/$filename/scancode/; 
done