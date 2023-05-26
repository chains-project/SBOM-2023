library(rjson)
library(ggVennDiagram)
library(ggplot2)
library(dplyr)
# READ THE json files from ./resultCalc each subfolder is a project
# 1. read the json file
files <- list.files(path = "sbom2023_plot/resultCalc", full.names = TRUE)
for (project in files) {
  venn_data <- list() # Initialize an empty list to store Venn diagram data
  producers <- list.files(path = project, pattern = "*.json", full.names = TRUE)
  producer_genes <- list() # Initialize an empty list to store genes for each producer

  for (producer in producers) {
    content <- fromJSON(file = producer)
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
    producer_genes[[tools::file_path_sans_ext(basename(producer))]] <- unlist(list_of_strings)
  }

  # Generate the Venn diagram
  venn <- Venn(producer_genes)
  data <- process_data(venn)
  ggplot() +
    # 1. region count layer
    geom_sf(aes(fill = count), data = venn_region(data)) +
    # 2. set edge layer
    geom_sf(aes(color = id), data = venn_setedge(data), show.legend = FALSE) +
    # 3. set label layer
    geom_sf_text(aes(label = name), data = venn_setlabel(data)) +
    # 4. region label layer
    geom_sf_label(aes(label = count), data = venn_region(data) %>% filter(count != 0), alpha = 0.5) +
    theme_void()
  
  # venn <- Venn(producer_genes)
  # plot <- ggVennDiagram(producer_genes, label = "count", edge_size = 2) +
  #   scale_color_brewer(palette = "Paired") +
  #   theme(
  #     plot.background = element_rect(fill = "white"),
  #   )
  # data <- process_data(venn)
  # Save the Venn diagram with high dpi
  ggsave(
    filename = paste("./venns", paste(basename(project), "pdf", sep = "."), sep = "/"),
    width = 13, height = 13, units = "in",
    dpi = 1200
  )
}
