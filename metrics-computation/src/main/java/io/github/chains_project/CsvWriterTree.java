package io.github.chains_project;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.DecimalFormat;
import io.github.chains_project.data.AnalyzerResult;
import io.github.chains_project.data.Metrics;

public class CsvWriterTree {
  public static void writeData(Path path) throws IOException {
    var list = new CreateDataTree().createData(path);
    StringBuilder sb = new StringBuilder();
    sb.append("project,analyzer,P,R,F1,SIZE");
    sb.append(System.lineSeparator());
    for (AnalyzerResult analyzerResult : list) {
      sb.append(analyzerResult.project());
      sb.append(",");
      sb.append(analyzerResult.name());
      sb.append(",");
      appendDirect(sb, analyzerResult);
    }
    Files.writeString(Path.of("./resultsTreeAll.csv"), sb.toString());
  }

  private static void appendDirect(StringBuilder sb, AnalyzerResult analyzerResult) {
    DecimalFormat df = new DecimalFormat("#.##");
    Metrics direct = Metrics.of(analyzerResult.deps());
    sb.append(df.format(direct.precision()));
    sb.append(",");
    sb.append(df.format(direct.recall()));
    sb.append(",");
    sb.append(df.format(direct.f1()));
    sb.append(",");
    sb.append(df.format(direct.size()));
    sb.append(",");
    sb.append(System.lineSeparator());
  }
}
