# Metrics computation

In this folder, you can find the code to compute the metrics from the SBOMs produced by the SBOM producers.
This code is written in Java and requires java 17 to run.

Build the jar with `mvn clean package`
RUN `java -jar target/metrics-computation-1.0.0-SNAPSHOT.jar $pathToResultsFolder`
`$pathToResultsFolder`is the folder where the results of the SBOM producers are stored

# Output files

resultsTreeAll.csv: contains the metrics for all the SBOMs
resultsTreeAverage.csv: contains the average metrics for each SBOM producer
resultTreeAverageWithoutFailures.csv contains the average metrics for each SBOM producer without the runs that failed to produce an SBOM

- project: the project name
- analyzer:  the analyzer used to produce the SBOM
- D_P:  precision of the SBOM on direct dependencies
- D_R: recall of the SBOM on direct dependencies
- D_F: f1-score of the SBOM on direct dependencies
- SIZE: the number of direct dependencies
- T_P:  precision of the SBOM on transitive dependencies
- T_R:  recall of the SBOM on transitive dependencies
- T_F:  f1-score of the SBOM on transitive dependencies
- SIZE:  the number of transitive dependencies
