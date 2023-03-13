FROM maven:3.8.3-openjdk-17
USER root
RUN git clone https://github.com/usnistgov/swid-tools/ && cd swid-tools && mvn install
COPY assembly.xml /
RUN mkdir --parents /results/${RepoName}
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && mkdir -p ./src/assembly/ && mv /assembly.xml ./src/assembly/bin.xml && mvn gov.nist.secauto.swid:swid-maven-plugin:0.7.1-SNAPSHOT:generate && ls

## CMD [git clone $Repo_URL && cd $Repo_Name && git checkout $CommitHash && cdxgen -t java -o bom.cdxgen.json]
