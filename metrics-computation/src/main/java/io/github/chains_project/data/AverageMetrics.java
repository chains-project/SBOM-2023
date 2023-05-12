package io.github.chains_project.data;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public record AverageMetrics(double precision, double recall, double f1, double size) {
  public static AverageMetrics calculateAverage(List<AnalyzerResult> results, Predicate<AnalyzerResult> filter) {
    results.removeIf(filter);
      List<Metrics> metrics =
          results.stream().map(v -> Metrics.of(v.deps())).collect(Collectors.toList());

      double directPrecision = metrics.stream().mapToDouble(v -> v.precision()).average().orElse(0);
      double directRecall = metrics.stream().mapToDouble(v -> v.recall()).average().orElse(0);
      double directF1 = metrics.stream().mapToDouble(v -> v.f1()).average().orElse(0);

      return new AverageMetrics(directPrecision, directRecall, directF1, metrics.size());
  }
}
