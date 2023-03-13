FROM maven:3.8.3-openjdk-17
USER root
RUN mkdir --parents /results/syft/${RepoName}
RUN curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} &&  syft . -o cyclonedx-json > sbom.json && ls


