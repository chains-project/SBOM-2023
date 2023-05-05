FROM maven:3.8.3-openjdk-17
USER root
RUN microdnf update && microdnf install -y npm
RUN npm install -g n
RUN n 16.16.0 && n prune
RUN git config --global advice.detachedHead false
RUN npm install -g @appthreat/cdxgen@8.4.3
RUN mkdir --parents /results/${RepoName}/cdxgen
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && cdxgen -t java -o bom.cdxgen.json

## CMD [git clone $Repo_URL && cd $Repo_Name && git checkout $CommitHash && cdxgen -t java -o bom.cdxgen.json]
