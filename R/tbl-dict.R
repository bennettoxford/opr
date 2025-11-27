library(yaml)

#' Load Table Dictionary from YAML
#'
#' Loads table metadata and column descriptions from YAML configuration.
#'
#' @param table_name Name of the table
#'
#' @return List with 'source', 'description', and 'columns' elements
#' @export
load_table_dict <- function(table_name) {
  # Find YAML file
  yaml_path <- system.file("table-descriptions.yml", package = "opr")
  if (yaml_path == "") {
    yaml_path <- here::here("inst", "table-descriptions.yml")
  }

  if (!file.exists(yaml_path)) {
    stop("YAML file not found at: ", yaml_path)
  }

  # Load and extract table info
  all_tables <- read_yaml(yaml_path)

  if (!table_name %in% names(all_tables)) {
    stop(
      "Table '",
      table_name,
      "' not found. Available: ",
      paste(names(all_tables), collapse = ", ")
    )
  }

  table_info <- all_tables[[table_name]]

  list(
    source = table_info$source,
    description = table_info$description,
    columns = unlist(table_info$columns)
  )
}
