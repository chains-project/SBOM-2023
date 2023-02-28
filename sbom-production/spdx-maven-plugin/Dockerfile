FROM maven:3.8.3-openjdk-17
USER root
RUN microdnf update && microdnf install -y npm
RUN mkdir --parents /results/${RepoName}
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} &&  mvn org.spdx:spdx-maven-plugin:0.5.4:createSPDX -DskipTests

## CMD [git clone $Repo_URL && cd $Repo_Name && git checkout $CommitHash && cdxgen -t java -o bom.cdxgen.json]
