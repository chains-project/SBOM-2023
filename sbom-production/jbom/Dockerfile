FROM maven:3.8.3-openjdk-11
USER root
RUN mkdir --parents /results/jbom/${RepoName}
COPY jbom-1.2.1.jar /jbom-1.2.1.jar
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && (mvn package -Dmaven.test.skip=true --fail-at-end) || true &&  java -jar /jbom-1.2.1.jar -d .



