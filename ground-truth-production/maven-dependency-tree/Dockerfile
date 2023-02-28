FROM maven:3.8.3-openjdk-17
USER root
# Get dependency tree in dot format
CMD git clone ${RepoUrl} && cd ${RepoName} && git checkout ${CommitHash} && mvn org.apache.maven.plugins:maven-dependency-plugin:3.4.0:tree -DoutputType=dot > tree.txt
