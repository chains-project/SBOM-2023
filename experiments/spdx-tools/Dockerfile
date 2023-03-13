FROM maven:3.8.3-openjdk-17
USER root
RUN mkdir --parents /results/spdx-tools/${RepoName}
COPY tools-java-1.1.3-jar-with-dependencies.jar /tools-java-1.1.3.jar
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && mkdir ./results_veri && java -jar /tools-java-1.1.3.jar GenerateVerificationCode . > ./results_veri/verificationcode.txt && ls && cd .. && ls



