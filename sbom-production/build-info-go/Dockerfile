FROM maven:3.8.3-openjdk-17
USER root
RUN microdnf update && microdnf install -y npm go
#RUN apt-get update && apt-get install -y golang-go git npm curl openjdk-17-jdk
#RUN curl -LO https://dlcdn.apache.org/maven/maven-3/3.9.0/binaries/apache-maven-3.9.0-bin.tar.gz
#RUN tar -xzf apache-maven-3.9.0-bin.tar.gz
#RUN mv apache-maven-3.9.0 /opt/maven
#RUN ln -s /opt/maven/bin/mvn /usr/local/bin

RUN git clone https://github.com/jfrog/build-info-go && cd build-info-go && git checkout b98f2c022f87e07240ecce29c2968d9f915ccf5a && ./buildscripts/build.sh
RUN mkdir --parents /results/${RepoName}
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && mv /build-info-go/bi . && ./bi mvn --format cyclonedx/json  > build-info-go.json

## CMD [git clone $Repo_URL && cd $Repo_Name && git checkout $CommitHash && cdxgen -t java -o bom.cdxgen.json]
