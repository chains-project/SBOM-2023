FROM maven:3.8.3-openjdk-17
USER root
RUN microdnf update && microdnf install -y python3.8
RUN python3 -m ensurepip && pip3 install --upgrade pip
RUN pip3 install scanoss
RUN mkdir --parents /results/scanoss/${RepoName}
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} &&  scanoss-py scan . > sbom.json

