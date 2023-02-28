FROM amd64/debian:bullseye-slim
USER root
RUN apt-get update && apt-get install -y git maven curl npm
RUN mkdir --parents /results/${RepoName}
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && (mvn org.openrewrite.maven:rewrite-maven-plugin:4.40.0:cyclonedx --fail-at-end) || true && curl https://github.com/CycloneDX/cyclonedx-cli/releases/download/v0.24.2/cyclonedx-linux-x64 -L --output cyclonedx && chmod +x cyclonedx && ./cyclonedx convert --input-file $(find ./target -name "*.xml") --output-format json --output-version v1_2 --output-file sbom.json

## CMD [git clone $Repo_URL && cd $Repo_Name && git checkout $CommitHash && cdxgen -t java -o bom.cdxgen.json]
