FROM --platform=linux/amd64 ubuntu:20.04
USER root
ENV TZ=Europe/Minsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y git
RUN apt-get install -y maven
RUN mkdir --parents /results/spdx-tools/${RepoName}
COPY spdx-sbom-generator /
RUN chmod +x /spdx-sbom-generator
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && /spdx-sbom-generator  && ls



