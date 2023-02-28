// usr/bin/env jbang "$0" "$@" ; exit $?
//DEPS com.fasterxml.jackson.core:jackson-databind:2.14.2

import java.io.FileReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;
import com.fasterxml.jackson.databind.ObjectMapper;

public class GraphParser {

  public static void main(String... args) {
    String path = args[0];

    try(Stream<Path> paths = Files.walk(Path.of(path))) {
      var results = paths.filter(v -> !v.toAbsolutePath().toString().contains("resources"))
      .filter(v -> v.toFile().getName().equals("pom.xml"))
          .toList();
      ObjectMapper mapper = new ObjectMapper();
      mapper.writeValue(Path.of("modules.json").toFile(), results);
    } catch (Exception e) {
      e.printStackTrace();
    }


  }
}
