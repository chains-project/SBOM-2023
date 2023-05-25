library(rjson)
library(ggVennDiagram)
library(ggvenn)

# READ THE json files from ./resultCalc each subfolder is a project
# 1. read the json file
print("foo")
files <- list.files(path = "sbom2023_plot/resultCalc", full.names = TRUE)
print(files)


for (project in files) {
  venn_data <- list() # Initialize an empty list to store Venn diagram data
  print(project)
  producers <- list.files(path = project, pattern = "*.json", full.names = TRUE)
  producer_genes <- list() # Initialize an empty list to store genes for each producer
  for (producer in producers) {
    content <- fromJSON(file = producer)
    print(producer)
    # get the array with the key "truePositive"
    truePositives <- content$truePositive
    # convert each json object to a string $groupdID:$artifactId:$version
    list_of_strings <- list()
    for (truePositive in truePositives) {
      # get the groupID
      groupID <- truePositive$groupId
      # get the artifactID
      artifactID <- truePositive$artifactId
      # get the version
      version <- truePositive$version
      # concatenate the strings
      string <- paste(groupID, artifactID, version, sep = ":")
      # add the string to the list
      list_of_strings <- append(list_of_strings, string)
    }
    print(length(list_of_strings))
    producer_genes[[tools::file_path_sans_ext(basename(producer))]] <- unlist(list_of_strings)
  }
  # Generate the Venn diagram
  plot <- ggVennDiagram(producer_genes, set_size = 5) +
    scale_color_brewer(palette = "Paired") +
    theme(
      plot.background = element_rect(fill = "white")
    )
  foo <- paste(basename(project), "pdf", sep = ".")
  # Save the Venn diagram with high dpi and increased whitespace
  ggsave(
    filename = paste("./venns",foo, sep = "/"),
    
    plot = plot,
    width = 13, height = 13, units = "in",
    dpi = 1200
  )
}
