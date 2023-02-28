# Ground truth production

We use [Maven Dependency Plugin](https://maven.apache.org/plugins/maven-dependency-plugin/)
version `3.4.0`.

## Format of this directory

1.  `maven-dependency-tree` directory:
    1. `Dockerfile` to list how to run the ground truth.
    2. `dot-to-json.py` is used for translate the `dot` format into JSON format.

2.  `generateGroundTruth.sh`: Each script iterates over `.env` file and runs
    all the ground truth for it.


## Process

1.  For each project, [Maven Dependency Plugin](https://maven.apache.org/plugins/maven-dependency-plugin/) is executed with the goal [`tree`](https://maven.apache.org/plugins/maven-dependency-plugin/tree-mojo.html). This process is performed in a docker container in order to ensure reproducibility. The Dockerfile used can be found in [`maven-dependency-tree/Dockerfile`](/ground-truth-production/maven-dependency-tree/Dockerfile).

2.  The output of the Maven Dependency Plugin is in the `.dot` format, which is translated into JSON by the [`maven-dependency-tree/dot-to-json.py`](maven-dependency-tree/dot-to-json.py) script.

3.  The resulting JSON files are stored in the
    `results-march-2023/<study-subject>/maven-dependency-tree` directory.

## Example

See [results-march-2023/checkstyle/maven-dependency-tree/tree.json](/results-march-2023/checkstyle/maven-dependency-tree/tree.json).
