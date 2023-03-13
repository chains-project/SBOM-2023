FROM amd64/debian:bookworm
USER root
RUN apt-get update && apt-get install -y git maven curl python3 python3-pip
RUN apt-get install -y libc6-dev libc6
RUN pip3 install spdx-tools
RUN curl -LO https://github.com/kubernetes-sigs/bom/releases/download/v0.4.1/bom-linux-amd64
RUN chmod +x bom-linux-amd64

RUN mkdir --parents /results/${RepoName}
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && /bom-linux-amd64 generate -n ${RepoUrl} . -o sbom.spdx && pyspdxtools_convertor -i sbom.spdx -o sbom.spdx.json -t json && ls

## CMD [git clone $Repo_URL && cd $Repo_Name && git checkout $CommitHash && cdxgen -t java -o bom.cdxgen.json]
