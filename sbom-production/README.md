# SBOM Production

## Format of this directory

It contains 3 types of files/folders.

1. `study-subjects-env`. It contains details of all the study subjects.
    1. `RepoUrl`
    1. `RepoName`
    1. `CommitHash`

    These are passed as arguments to the docker image later. 

1.  **Folder based on tool name**. Example: `build-info-go`.
    These folders contain at least a `Dockerfile` that outlines instructions
    to setup the producer so that it can be executed on the [study subjects](/study-subjects.md)
    using the arguments above.

1.  **Bash script based on tool name**. Example: `build-info-go.sh`.
    Each script iterates over `.env` file and runs all the producers for it.
    It, finally, produces the SBOM file and puts it in [`results-march-2023/<study-subject>/<producer>`](/results-march-2023/).

## Process

We run [6 SBOM producers](/sbom-production/producers.md) on [26 projects](/study-subjects.md).

1. [generateAll](/sbom-production/generateAll.sh) script is invoked.
2. The script invokes respective script for each producer.
3. SBOM is stored in [`results-march-2023/<study-subject>/<producer>`](/results-march-2023/).

## Example SBOM

See [SBOM for `alluxio` produced by `cdxgen`](/results-march-2023/alluxio/cdxgen/bom.cdxgen.json).

