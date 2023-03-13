FROM amd64/debian:bullseye-slim
RUN apt-get update && apt-get install -y git curl libicu-dev
USER root
RUN mkdir --parents /results/${RepoName}
RUN curl -Lo sbom-tool https://github.com/microsoft/sbom-tool/releases/latest/download/sbom-tool-linux-x64 && chmod +x sbom-tool
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && /sbom-tool generate -b . -bc . -pn ${RepoName} -pv 1 -ps ${RepoName}  -nsb ${RepoUrl} && ls