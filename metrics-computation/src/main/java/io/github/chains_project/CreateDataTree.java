package io.github.chains_project;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import io.github.chains_project.data.AnalyzerResult;
import io.github.chains_project.data.Dependency;
import io.github.chains_project.data.Result;

public class CreateDataTree {

  private static final List<String> analyzerNames = List.of("build-info-go", "cdxgen",
      "cyclonedx-maven-plugin", "depscan", "jbom", "openrewrite");

  public List<AnalyzerResult> createData(Path resultFolder) throws IOException {
    List<AnalyzerResult> results = new ArrayList<>();
    Locale.setDefault(Locale.US);
    for (Path project : Files.list(resultFolder).toArray(Path[]::new)) {
      Path truthJson = getMavenTruth(project);
      if (truthJson == null) {
        System.out.println("No truth for " + project.getFileName());
        continue;
      }
      for (String analyzerName : analyzerNames) {
        try {
          Path analyzerResult = project.resolve(analyzerName);
          if (!Files.exists(analyzerResult)) {
            addEmptyResult(results, project, analyzerName);
            continue;
          }
          String sbomType = SbomType.fileNameToType(analyzerResult.getFileName().toString());
          if (sbomType.isEmpty() || sbomType.equals("truth")) {
            continue;
          }

          Path file = Files.createTempFile("chains", ".json");
          Path inputFile = findJsonFile(analyzerResult);
          if (inputFile == null) {
            addEmptyResult(results, project, analyzerName);
            continue;
          }

          if (!PythonRunner.invokePython(inputFile, file, sbomType)) {
            addEmptyResult(results, project, analyzerName);
            continue;
          }
          FileReader jsonReader = new JsonReader();
          List<Dependency> input = jsonReader.readFile(file);
          List<Dependency> truth = jsonReader.readFile(truthJson);
          var numbers = Result.of(input, truth);
          AnalyzerResult result = new AnalyzerResult(analyzerName, project.getFileName().toString(),
              numbers);
          results.add(result);
        } catch (Exception e) {
          e.printStackTrace();
        }
      }
    }
    return results;
  }

  private void addEmptyResult(List<AnalyzerResult> results, Path project, String analyzerName) {
    results.add(new AnalyzerResult(analyzerName, project.getFileName().toString(),
        Result.empty()));
  }


  private Path getMavenTruth(Path project) throws IOException {
    try(var stream = Files.walk(project)) {
      return findJsonFile(stream
          .filter(v -> v.getFileName().toString().equals("maven-dependency-tree")).findAny()
          .orElse(null));
    }
  }

  private Path findJsonFile(Path folder) throws IOException {
    if (folder == null) {
      return null;
    }
    try(var stream = Files.walk(folder)) {
      return stream.filter(v -> v.getFileName().toString().endsWith(".json")).findAny()
          .orElse(null);
    }
  }
}
