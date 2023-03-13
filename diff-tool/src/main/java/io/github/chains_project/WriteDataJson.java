package io.github.chains_project;

import java.io.IOException;
import java.nio.file.Path;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.github.chains_project.data.AnalyzerResult;

public class WriteDataJson {
  public static void main(String[] args) throws IOException {
   ObjectMapper mapper = new ObjectMapper();
   var data = new CreateDataTree().createData(Path.of("./results"));
   mapper.writeValue(Path.of("./data.json").toFile(), data);
  for (AnalyzerResult analyzerResult : data) {
    String name = analyzerResult.name();
    String project = analyzerResult.project();
    int dd = analyzerResult.direct().truePositive().size()
        + analyzerResult.direct().falseNegative().size();
    int td = analyzerResult.transitive().truePositive().size()
        + analyzerResult.transitive().falseNegative().size();
        int sum = dd + td;
    System.out.println(name + " " + project + " " + dd + " " + td + " " + sum);    
    
  }
  }
}
