package io.github.chains_project;

public class SbomType {
  
  public static String fileNameToType(String fileName) {
    return switch (fileName) {

      case "build-info-go" -> "cyclonedx";
      case "cdxgen" -> "cyclonedx";
      case "cyclonedx-maven-plugin" -> "cyclonedx";
      case "depscan" -> "cyclonedx";
      case "jbom" -> "jbom"; // it is almost cyclonedx but not quite
      case "maven-dependency-tree" -> "truth";
      case "openrewrite" -> "openrewrite";
      default -> "";
    };
  }
}
