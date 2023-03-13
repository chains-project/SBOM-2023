FROM maven:3.8.3-openjdk-17
USER root
RUN mkdir --parents /results/${RepoName}/cyclonedx-maven-plugin
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && mvn org.cyclonedx:cyclonedx-maven-plugin:2.7.5:makeAggregateBom
