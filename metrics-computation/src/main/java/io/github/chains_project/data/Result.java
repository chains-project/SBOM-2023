package io.github.chains_project.data;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public record Result(List<Dependency> truePositive, List<Dependency> falsePositive,
    List<Dependency> falseNegative) {

  public static Result empty() {
    List<Dependency> truePositive = List.of();
    List<Dependency> falsePositive = List.of();
    List<Dependency> falseNegative = List.of();
    return new Result(truePositive, falsePositive, falseNegative);
  }
      
  public static Result of(List<Dependency> input, List<Dependency> truth) {
    List<Dependency> truePositive = truePositives(input, truth);
    List<Dependency> falsePositive = falsePositives(input, truth);
    List<Dependency> falseNegative = falseNegatives(input, truth);
    return new Result(truePositive, falsePositive, falseNegative);

  }
  
  /**
  * Calculates the true positives, all dependencies that are in both lists.
  * @param input The first list.
  * @param truth  The second list.
  * @return
  */
  private static List<Dependency> truePositives(List<Dependency> input, List<Dependency> truth) {
    Set<Dependency> firstSet = new HashSet<>(input);
    Set<Dependency> secondSet = new HashSet<>(truth);
    var diffFirst = new HashSet<>(firstSet);
    diffFirst.retainAll(secondSet);
    return new ArrayList<>(diffFirst);
  }

  private static List<Dependency> falsePositives(List<Dependency> input, List<Dependency> truth) {
    Set<Dependency> firstSet = new HashSet<>(input);
    Set<Dependency> secondSet = new HashSet<>(truth);
    var diffFirst = new HashSet<>(firstSet);
    diffFirst.removeAll(secondSet);
    return new ArrayList<>(diffFirst);
  }

  // All that are in the truth but not in the input.
  private static List<Dependency> falseNegatives(List<Dependency> input, List<Dependency> truth) {
    var diffFirst = new HashSet<>(truth);
    diffFirst.removeAll(new HashSet<>(input));
    return new ArrayList<>(diffFirst);
  }
}