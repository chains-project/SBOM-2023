FROM maven:3.8.3-openjdk-17
USER root
RUN git clone https://github.com/oss-review-toolkit/ort.git && cd ort && ./gradlew installDist && ls
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && /ort/cli/build/install/ort/bin/ort analyze -i . -o /results/ort/ -f JSON && ls

## CMD [git clone $Repo_URL && cd $Repo_Name && git checkout $CommitHash && cdxgen -t java -o bom.cdxgen.json]
