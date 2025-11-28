# OpenPrescribing in R (opr)

This is a brief tutorial for accessing and analysing the [OpenPrescribing.net](https://openprescribing.net/) BigQuery database in R. The main goals are to help researchers (1) understand the available data and (2) write readable, reusable, and modular queries for analysing prescribing data. This tutorial covers:

- Connecting to BigQuery from R
- Understanding the database schema
- Writing reusable functions for common queries
- Applied examples of prescription data analysis

The full tutorial is available online at [https://bennettoxford.github.io/opr/](https://bennettoxford.github.io/opr/).

## For R users

If you want to use the methods described in this tutorial, install these R packages:

```r
install.packages(c(
  "DBI",
  "bigrquery",
  "dbplyr",
  "dm",
  "dplyr",
  "tidyverse"
))
```

You'll also need BigQuery credentials (see the tutorial for setup instructions).

You can use R in [VS Code](https://code.visualstudio.com/docs/languages/r), [RStudio](https://posit.co/products/open-source/rstudio/), or any other IDE that supports R. I enojy working in [Positron](https://posit.co/products/ide/positron/) (the new RStudio based on VS Code) because it feels like I'm working in VS Code but with great R support. 

## For contributors

If you want to contribute to this tutorial, you'll need the packages above plus:

**R packages:**

```r
install.packages(c(
  "quarto",
  "yaml",
  "cli"
))
```

**Development tools:**

- [Quarto](https://quarto.org/docs/get-started/) for building the quarto book
- [air](https://posit-dev.github.io/air/) for formatting R code (available as a [CLI tool](https://posit-dev.github.io/air/cli.html) or [VS Code extension](https://posit-dev.github.io/air/editor-vscode.html))

## Building the book

Preview the book locally with:

```bash
quarto preview
```

Publish the book on GitHub Pages with:

```bash
quarto publish gh-pages
```