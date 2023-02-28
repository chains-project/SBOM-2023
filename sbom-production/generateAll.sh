#!/bin/bash

# We use a volume to cache dependencies between builds.
docker volume create maven-deps

# The six SBOM producers
bash ./build-info-go.sh
bash ./cdxgen.sh
bash ./cyclonedx-maven-plugin.sh
bash ./jbom.sh
bash ./openrewrite.sh
bash ./depscan.sh
