// usr/bin/env jbang "$0" "$@" ; exit $?
//DEPS com.fasterxml.jackson.core:jackson-databind:2.14.2

import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;
import com.fasterxml.jackson.databind.ObjectMapper;

public class GraphParser {

  public static void main(String... args) {

    try {
      String inputFile = args[0];
      String outputFile = args[1];
      ObjectMapper mapper = new ObjectMapper();
      JsonFile file = mapper.readValue(new FileReader(inputFile), JsonFile.class);
      List<Dependency> results = new ArrayList<>();
      for (Node node : file.artifacts) {
        var subGraph = getChildNodes(node, file.artifacts, file.dependencies);
        for (Node subNode : subGraph) {
          Dependency dep = new Dependency(subNode.groupId, subNode.artifactId,
              subNode.classifiers == null ? List.of().toString() : subNode.classifiers.toString(),
              subNode.version, subNode.scopes == null ? "" : subNode.scopes.toString(), 2, node.id);
          results.add(dep);
        }
      }
      List<Dependency> modules = new ArrayList<>();
      List<Node> moduleNodes = new ArrayList<>();
      for (Node node : file.artifacts) {
        String artifactId = node.artifactId;
        String groupId = node.groupId;
        String version = node.version;
        if (results.stream().noneMatch(v -> v.artifactId.equals(artifactId)
            && v.groupId.equals(groupId) && v.version.equals(version))) {
          modules.add(new Dependency(node.groupId, node.artifactId,
              node.classifiers == null ? List.of().toString() : node.classifiers.toString(),
              node.version, node.scopes == null ? "" : node.scopes.toString(), 0, ""));
          moduleNodes.add(node);
        }
      }
      System.out.println("Modules: " + modules.size());
      List<Dependency> finalResults = new ArrayList<>();
      for (Dependency dep : new ArrayList<>(results)) {
        String[] id = dep.submodule.split(":");
        String groupId = id[0];
        String artifactId = id[1];
        if (moduleNodes.stream()
            .anyMatch(v -> v.artifactId.equals(artifactId) && v.groupId.equals(groupId))) {
          System.out.println("Removing: " + dep);
          results.remove(dep);
          finalResults.add(new Dependency(dep.groupId, dep.artifactId, dep.classifier, dep.version,
              dep.scope, 1, dep.submodule));
        }
      }
      finalResults.addAll(results);
      mapper.writeValue(new java.io.File(outputFile), finalResults);
      System.out.println("Result file status: " + new java.io.File(outputFile).exists());
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  record Node(String id, int numericId, String groupId, String artifactId, String version,
      boolean optional, List<String> classifiers, List<String> scopes, List<String> types) {
  }

  record Edge(String from, String to, int numericFrom, int numericTo, String resolution) {
  }


  public record JsonFile(String graphName, List<Node> artifacts, List<Edge> dependencies) {
  }
  /*
   *   {
    "groupId": "junit",
    "artifactId": "junit",
    "classifier": "jar",
    "version": "4.13.2",
    "scope": "test",
    "depth": 1,
    "submodule": "com.google.errorprone:error_prone_annotation:jar:2.17.0"
  },
   */
  // q: create a json record for this
  record Dependency(String groupId, String artifactId, String classifier, String version,
      String scope, int depth, String submodule) {
  };


  record GraphNode(Node parent, List<Node> dependencies) {
  };

  private static List<Node> getChildNodes(Node node, List<Node> nodes, List<Edge> edges) {
    List<Node> result = new ArrayList<>();
    for (Edge edge : edges) {
      if (edge.from.equals(node.id)) {
        nodes.stream().filter(v -> v.id.equals(edge.to)).forEach(result::add);

      }
    }
    return result;
  }
}
