package io.github.chains_project;

import java.io.IOException;
import java.nio.file.Path;

public class RunAllDataCreation {
  
  public static void main(String... args) throws IOException {
    // Path pathToResults = Path.of(args[0]);
    Path pathToResults = Path.of("C:/Users/Administrator/OneDrive/programmieren/SBOM-2023/sbom-production/results");
    new CreateDataTree().createData(pathToResults);
    var list = new CreateDataTree().createData(pathToResults);
    CsvWriterAverage.createCSV(list, "resultsTreeAverage");
    new LargeTableGenerator().createData(pathToResults);
    CsvWriterTree.writeData(pathToResults);
  }
}
