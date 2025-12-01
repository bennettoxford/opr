#' Create Data Dictionary Table
create_data_dict <- function(df, table_or_dict) {
  # Load from YAML if string, otherwise use as dictionary
  if (
    is.character(table_or_dict) &&
      length(table_or_dict) == 1 &&
      is.null(names(table_or_dict))
  ) {
    table_info <- load_table_dict(table_or_dict)
    desc_dict <- table_info$columns
    table_name <- table_or_dict
    table_source <- table_info$source
  } else {
    desc_dict <- table_or_dict
    table_name <- NULL
    table_source <- NULL
  }

  # Build data dictionary tibble
  col_names <- names(df)
  descriptions <- desc_dict[col_names]

  missing <- col_names[is.na(descriptions)]
  if (length(missing) > 0) {
    warning("Missing descriptions for: ", paste(missing, collapse = ", "))
  }

  tbl_data <- tibble(
    column_name = col_names,
    data_type = vapply(df, function(x) class(x)[1], character(1)),
    description = unname(descriptions)
  )

  # Format as gt table
  gt_tbl <- tbl_data |>
    gt() |>
    cols_label(
      column_name = md("**Columns**"),
      data_type = "",
      description = ""
    ) |>
    fmt_markdown(columns = everything()) |>
    cols_align(align = "left", columns = everything()) |>
    tab_style(
      style = cell_text(
        align = "left", 
        v_align = "top",
        weight = "bold", 
        font = "monospace"
      ),
      locations = cells_body(columns = column_name)
    ) |>
    tab_style(
      style = cell_text(
        align = "left", 
        v_align = "top",
        style = "italic",
        color = "grey50",
        font = "monospace"
      ),
      locations = cells_body(columns = data_type)
    ) |>
    tab_style(
      style = cell_text(
        align = "left", 
        v_align = "top"
      ),
      locations = cells_body(columns = description)
    ) |>
    tab_source_note(
      source_note = md(sprintf(
        "**Rows** %s  **Columns** %s",
        format(nrow(df), big.mark = ","),
        ncol(df)
      ))
    ) |>
    tab_options(
      table.font.size = px(14),
      heading.align = "left",
      table.align="left"
    )

  gt_tbl
}
