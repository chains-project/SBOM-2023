package io.github.chains_project;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import io.github.chains_project.data.AnalyzerResult;
import io.github.chains_project.data.Dependency;
import io.github.chains_project.data.Metrics;
import io.github.chains_project.data.Result;

public class CsvWriterAverage {

  public static void createCSVAverage() throws IOException {
    var list = new CreateDataTree().createData(Path.of("./results"));
    createCSV(list, "resultsTreeAverage");

  }

  public static void createCSV(List<AnalyzerResult> list, String fileName) throws IOException {
    StringBuilder sb = new StringBuilder();
    sb.append("analyzer,P,R,F1");
    sb.append(System.lineSeparator());
    calculateAverage(new ArrayList<>(list), v -> false).forEach(v -> {
      sb.append(v.name());
      sb.append(";");
      sb.append(v.directPrecision());
      sb.append(";");
      sb.append(v.directRecall());
      sb.append(";");
      sb.append(v.directF1());
      sb.append(System.lineSeparator());
    });
    Files.writeString(Path.of("./" + fileName + ".csv"), sb.toString());
    sb.setLength(0);
    sb.append("analyzer,P,R,F1");
    sb.append(System.lineSeparator());
    calculateAverage(new ArrayList<>(
        list), v -> v.deps().truePositive().isEmpty() && v.deps().falsePositive()
        .isEmpty()).forEach(v -> {
      sb.append(v.name());
      sb.append(";");
      sb.append(v.directPrecision());
      sb.append(";");
      sb.append(v.directRecall());
      sb.append(";");
      sb.append(v.directF1());
      sb.append(System.lineSeparator());
    });
    Files.writeString(Path.of("./" + fileName + "WithoutFailures.csv"), sb.toString());
  }
  /**
   * Calculates the average of the metrics for each analyzer.
   * @param results the results
   * @param filter  the filter to remove results from the calculation (e.g. to remove results with no true positives), Any result that matches the filter will be removed from the list.
   * @return  the average metrics for each analyzer
   */
  private static List<AverageMetrics> calculateAverage(List<AnalyzerResult> results, Predicate<AnalyzerResult> filter) {
    List<AverageMetrics> averages = new ArrayList<>();
    results.removeIf(filter);
    var map = results.stream().collect(Collectors.groupingBy(v -> v.name()));
    for (var entry : map.entrySet()) {
      List<Metrics> metrics = entry.getValue().stream().map(v -> Metrics.of(v.deps()))
          .collect(Collectors.toList());

      double directPrecision =
          metrics.stream().mapToDouble(v -> v.precision()).average().orElse(0);
      double directRecall = metrics.stream().mapToDouble(v -> v.recall()).average().orElse(0);
      double directF1 = metrics.stream().mapToDouble(v -> v.f1()).average().orElse(0);

       averages.add(new AverageMetrics(entry.getKey() ,directPrecision, directRecall, directF1));

    }
    return averages;
  }
    
  record AverageMetrics(String name, double directPrecision, double directRecall, double directF1) {
  }
}
