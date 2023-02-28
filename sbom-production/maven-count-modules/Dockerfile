FROM maven:3.8.3-openjdk-17
COPY jbang-0.104.0.zip /jbang-0.104.0.zip
# Install jbang
RUN jar xf jbang-0.104.0.zip && \
  rm jbang-0.104.0.zip && \
  mv jbang-* jbang && \
  chmod +x jbang/bin/jbang
ENV PATH="${PATH}:/jbang-0.104.0/bin"
ENV JBANG_VERSION 0.104.0
ENV JBANG_PATH=/jbang/bin
ENV PATH="${PATH}:/jbang/bin"
# check if jbang is installed
RUN jbang --help
USER root
COPY GraphParser.java /GraphParser.java
RUN jbang --fresh app install /GraphParser.java
# Get dependency tree in dot format
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && jbang /GraphParser.java "."
