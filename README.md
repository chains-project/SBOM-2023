# Code and data for _Challenges of Producing Software Bill Of Materials for Java_

## Overview
This repository contains the code and data produced for the paper [_Challenges of Producing Software Bill Of Materials for Java_](https://arxiv.org/abs/2303.11102) (IEEE Security \& Privacy, 2023). 
```bibtex
@article{sbomchallenges,
 title = {Challenges of Producing Software Bill Of Materials for Java},
 journal = {IEEE Security \& Privacy},
 year = {2023},
 doi = {10.1109/MSEC.2023.3302956},
 author = {Musard Balliu and Benoit Baudry and Sofia Bobadilla and Mathias Ekstedt and Martin Monperrus and Javier Ron and Aman Sharma and Gabriel Skoglund and César Soto-Valero and Martin Wittlinger},
 url = {http://arxiv.org/pdf/2303.11102},
}
```
The structure of the repository is as follows:

* [`sbom-production`](sbom-production) contains all scripts used for creating [CycloneDX](https://www.cyclonedx.org/) SBOM files for each of the 26 study subjects using 6 different SBOM producers.
* [`ground-truth-production`](ground-truth-production) contains all scripts used for extracting a ground truth dataset of dependency trees for each study subject.
* [`metrics-computation`](metrics-computation) contains all code used for computing metrics relating to the performance of the SBOM tools.
* [`results-march-2023`](results-march-2023) contains all experimental data.
* [`sbom2023_plot`](sbom2023_plot) contains additional code and resources related to the creation of figures for the paper.


## SBOM Producers
The performance of the following 6 CycloneDX SBOM producers were studied:

> These are the latest versions as of `Fri 5 May 2023 13:02:33 CEST`.

| Producer | Version |
| -------- | ------- | 
| [Build Info Go](https://github.com/jfrog/build-info-go) | 1.9.3 |
| [CycloneDX Generator](https://github.com/CycloneDX/cdxgen) | 8.4.3 |
| [CycloneDX Maven Plugin](https://github.com/CycloneDX/cyclonedx-maven-plugin) | 2.7.8 |
| [jbom](https://github.com/Contrast-Security-OSS/jbom) | 1.2.1 |
| [OpenRewrite](https://docs.openrewrite.org/reference/rewrite-maven-plugin) | 4.45.0 |
| [Depscan](https://github.com/AppThreat/dep-scan) | 4.1.2 |


## Study Subjects
The following versions of 26 Java projects using Maven were selected as study subjects:

| # | GitHub Repository | Commit Hash | Stable release as of 01.01.23 |
| - | ----------------- | ----------- | ----------------------------- |
| 1 | [jenkins](https://github.com/jenkinsci/jenkins) | [ce7e5d7](https://github.com/jenkinsci/jenkins/commit/ce7e5d70373a36c8d26d4117384a9c5cb57ff1c1) | [2.384](https://mvnrepository.com/artifact/org.jenkins-ci.main/jenkins-core/2.384) |  |  |
| 2 | [mybatis-3](https://github.com/mybatis/mybatis-3) | [c195f12](https://github.com/mybatis/mybatis-3/commit/c195f12808a88a1ee245dc86d9c1621042655970) | [3.5.11](https://mvnrepository.com/artifact/org.mybatis/mybatis/3.5.11) |  |  |
| 3 | [flink](https://github.com/apache/flink) | [c41c8e5](https://github.com/apache/flink/commit/c41c8e5cfab683da8135d6c822693ef851d6e2b7) | [1.15.3](https://mvnrepository.com/artifact/org.apache.flink/flink-core/1.15.3) |  |  |
| 4 | [checkstyle](https://github.com/checkstyle/checkstyle) | [233c91b](https://github.com/checkstyle/checkstyle/commit/233c91be45abc1ddf67c1df7bc8f9f8ab64caa1c) | [10.6.0](https://mvnrepository.com/artifact/com.puppycrawl.tools/checkstyle/10.6.0) |  |  |
| 5 | [CoreNLP](https://github.com/stanfordnlp/CoreNLP) | [f7782ff](https://github.com/stanfordnlp/CoreNLP/commit/f7782ff5f235584b0fc559f266961b5ab013556a) | [4.5.1](https://mvnrepository.com/artifact/edu.stanford.nlp/stanford-corenlp/4.5.1) |  |  |
| 6 | [neo4j](https://github.com/neo4j/neo4j) | [c082e80](https://github.com/neo4j/neo4j/commit/c082e80b792d46ad1b342fbf7f1facb2028344c6) | [5.3.0](https://mvnrepository.com/artifact/org.neo4j/neo4j-collections/5.3.0) |  | [Central](https://mvnrepository.com/repos/central) |
| 7 | [async-http-client](https://github.com/AsyncHttpClient/async-http-client) | [7a370af](https://github.com/AsyncHttpClient/async-http-client/commit/7a370af58dc8895a27a14d0a81af2a3b91930651) | [2.12.3](https://mvnrepository.com/artifact/org.asynchttpclient/async-http-client/2.12.3) |  |  |
| 8 | [error-prone](https://github.com/google/error-prone) | [27de40b](https://github.com/google/error-prone/commit/27de40ba6008f967c01a55ec83c9127419bfe433) | [2.17.0](https://mvnrepository.com/artifact/com.google.errorprone/error_prone_core/2.17.0) |  |  |
| 9 | [alluxio](https://github.com/Alluxio/alluxio) | [d5919d8](https://github.com/Alluxio/alluxio/commit/d5919d8d80ae7bfdd914ade30620d5ca14f3b67e) | [2.9.0](https://mvnrepository.com/artifact/org.alluxio/alluxio-core-transport/2.9.0) |  |  |
| 10 | [javaparser](https://github.com/javaparser/javaparser) | [1ae25f3](https://github.com/javaparser/javaparser/commit/1ae25f3f77f5d680c135d0742257ccd62916f17d) | [3.15.15](https://mvnrepository.com/artifact/com.github.javaparser/javaparser-symbol-solver-logic/3.15.15) |  |  |
| 11 | [undertow](https://github.com/undertow-io/undertow) | [f52b70c](https://github.com/undertow-io/undertow/commit/f52b70c1520277a1552f0f453c2a908897a8a5dc) | [2.3.2.Final](https://mvnrepository.com/artifact/io.undertow/undertow-benchmarks/2.3.2.Final) |  |  |
| 12 | [webcam-capture](https://github.com/sarxos/webcam-capture) | [e19125c](https://github.com/sarxos/webcam-capture/commit/e19125c2c728a856231a3b507372e94e02fdfd35) | [0.3.12](https://mvnrepository.com/artifact/com.github.sarxos/webcam-capture-driver-openimaj/0.3.12) |  |  |
| 13 | [handlebars.java](https://github.com/jknack/handlebars.java) | [2afc50f](https://github.com/jknack/handlebars.java/commit/2afc50fd5dcd32af28f8305b59689b3fec4a3b07) | [4.2.1](https://mvnrepository.com/artifact/com.github.jknack/handlebars-markdown/4.2.1) |  |  |
| 14 | [jooby](https://github.com/jooby-project/jooby) | [f71b551](https://github.com/jooby-project/jooby/commit/f71b551213ac03523e44a7fbb8c972b752ffc707) | [3.0.0.M1](https://mvnrepository.com/artifact/io.jooby/jooby/3.0.0.M1) |  |  |
| 15 | [tika](https://github.com/apache/tika) | [41319f3](https://github.com/apache/tika/commit/41319f3c294b13de5342a80570b4540f7dd04a3e) | [2.6.0](https://mvnrepository.com/artifact/org.apache.tika/tika-parsers/2.6.0) |  |  |
| 16 | [orika](https://github.com/orika-mapper/orika) | [eef8209](https://github.com/orika-mapper/orika/commit/eef82092c8a9dfda04192a5378fa0e49d70ade3a) | [1.5.4](https://mvnrepository.com/artifact/ma.glasnost.orika/orika-eclipse-tools/1.5.4) |  |  |
| 17 | [spoon](https://github.com/INRIA/spoon) | [ee73f43](https://github.com/INRIA/spoon/commit/ee73f4376aa929d8dce950202fabb8992a77c9fb) | [10.2.0](https://mvnrepository.com/artifact/fr.inria.gforge.spoon/spoon-core/10.2.0) |  |  |
| 18 | [accumulo](https://github.com/apache/accumulo) | [706612f](https://github.com/apache/accumulo/commit/706612f859d6e68891d487d624eda9ecf3fea7f9) | [2.1.0](https://mvnrepository.com/artifact/org.apache.accumulo/accumulo-core/2.1.0) |  |  |
| 19 | [couchdb-lucene](https://github.com/rnewson/couchdb-lucene) | [8554737](https://github.com/rnewson/couchdb-lucene/commit/855473709bd4e3d92d3f62ece86ab739d0f0de13) | [2.1.0](https://github.com/rnewson/couchdb-lucene/releases/tag/v2.1.0) |  |  |
| 20 | [jHiccup](https://github.com/giltene/jHiccup) | [a440bda](https://github.com/giltene/jHiccup/commit/a440bdaed143e1445cbeab7c5bffd30989a435d0) | [2.0.10](https://github.com/giltene/jHiccup/releases/tag/jHiccup-2.0.10) |  |  |
| 21 | [vulnerability-assessment-tool](https://github.com/SAP/vulnerability-assessment-tool) | [3d261af](https://github.com/SAP/vulnerability-assessment-tool/commit/3d261afe9513f7c708324aa0183423ab2e9e4692) | [3.2.5](https://mvnrepository.com/artifact/org.eclipse.steady/shared/3.2.5) |  |  |
| 22 | [para](https://github.com/Erudika/para) | [41d9005](https://github.com/Erudika/para/commit/41d900574e2e159b05fbd23aaab1f6e554ab8fc3) | [1.47.2](https://mvnrepository.com/artifact/com.erudika/para-core/1.47.2) |  |  |
| 23 | [launch4j-maven-plugin](https://github.com/orphan-oss/launch4j-maven-plugin) | [3f9818e](https://github.com/orphan-oss/launch4j-maven-plugin/commit/3f9818ee34b36cdcea58e2d6e6542f140b394faf) | [2.2.0](https://mvnrepository.com/artifact/com.akathist.maven.plugins.launch4j/launch4j-maven-plugin/2.2.0) |  |  |
| 24 | [jacop](https://github.com/radsz/jacop) | [1a395e6](https://github.com/radsz/jacop/commit/1a395e6add22caf79590fe9d1b2223bfb6ed0cd0) | [4.9.0](https://mvnrepository.com/artifact/org.jacop/jacop/4.9.0) |  |  |
| 25 | [selenese-runner-java](https://github.com/vmi/selenese-runner-java) | [3e84e8e](https://github.com/vmi/selenese-runner-java/commit/3e84e8e4e7e06aa1bdacaa8266db00f62ebef559) | [4.2.0](https://mvnrepository.com/artifact/jp.vmi/selenese-runner-java/4.2.0) |  |  |
| 26 | [commons-configuration](https://github.com/apache/commons-configuration) | [59e5152](https://github.com/apache/commons-configuration/commit/59e5152722198526c6ffe5361de7d1a6a87275c7) | [2.8.0](https://mvnrepository.com/artifact/org.apache.commons/commons-configuration2/2.8.0) |  |  |


## Reproduction
If you are interested in reproducing our results, the script [`reproduce.sh`](reproduce.sh) is provided for your convenience. This script will do the following:

* Generate SBOMs for each study subject and SBOM producer.
* Extract ground truth dependency information from each study subject.
* Calculate the accuracy/precision for each SBOM producer and compare these values with our results, outputting whether the values match or not.

> :warning: Please note that this script can take a considerable amount of time (~2 hours on a laptop) since SBOM production needs to be carried out by 6 different producers on 26 different study subjects. 

### The following software is required for reproduction:
* Java version 17 or newer
* Apache Maven 
* Docker
* Python 3.10 or newer
