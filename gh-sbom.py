l = [
"https://github.com/apache/tika/",
"https://github.com/Alluxio/alluxio/",
"https://github.com/jooby-project/jooby/",
"https://github.com/neo4j/neo4j/",
"https://github.com/apache/flink/",
"https://github.com/eclipse/steady/",
"https://github.com/Erudika/para/",
"https://github.com/jenkinsci/jenkins/",
"https://github.com/apache/accumulo/",
"https://github.com/vmi/selenese-runner-java/",
"https://github.com/undertow-io/undertow/",
"https://github.com/jknack/handlebars.java/",
"https://github.com/google/error-prone/",
"https://github.com/AsyncHttpClient/async-http-client/",
"https://github.com/rnewson/couchdb-lucene/",
"https://github.com/mybatis/mybatis-3/",
"https://github.com/orphan-oss/launch4j-maven-plugin/",
"https://github.com/checkstyle/checkstyle/",
"https://github.com/orika-mapper/orika/",
"https://github.com/apache/commons-configuration/",
"https://github.com/INRIA/spoon/",
"https://github.com/sarxos/webcam-capture/",
"https://github.com/javaparser/javaparser/",
"https://github.com/stanfordnlp/CoreNLP/",
"https://github.com/radsz/jacop/",
"https://github.com/giltene/jHiccup/",
]

import subprocess
import os
from urllib.parse import urlparse


for url in l:
    sbom_url = url + "dependency-graph/sbom"
    project_name = urlparse(url).path.split("/")[2]

    path_to_project = os.path.join("results-march-2023", project_name)
    os.makedirs(os.path.join(path_to_project, "gh-sbom"), exist_ok=True)

    subprocess.run([
        "wget",
        sbom_url,
        "-O"
        f"{path_to_project}/gh-sbom/spdx.json",
        "--header",
        "Cookie: user_session=lQllC87vAeR_Zerb_HGcmn4CVSV6yLXQ86LKEtq5j2Pp-wyN",
        ])

    