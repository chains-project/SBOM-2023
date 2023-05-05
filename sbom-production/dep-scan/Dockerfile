FROM amd64/debian:bookworm
USER root
RUN apt-get update && apt-get install -y git maven curl python3 npm
RUN apt-get install -y libc6-dev libc6
RUN curl -LO https://github.com/AppThreat/depscan-bin/releases/download/v4.1.2/depscan-linux-amd64
RUN chmod +x depscan-linux-amd64

RUN mkdir --parents /results/${RepoName}
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && /depscan-linux-amd64 -i .

## CMD [git clone $Repo_URL && cd $Repo_Name && git checkout $CommitHash && cdxgen -t java -o bom.cdxgen.json]
