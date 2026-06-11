set positional-arguments := true

alias help := list

# List available commands
list:
    @just --list --unsorted

# Format R code using air, see air.toml
fix:
    air format .

# Document package using roxygen
document:
    Rscript --quiet --vanilla -e 'devtools::document()'

# Build and install package
build:
    Rscript --quiet --vanilla -e 'pak::local_install()'

# Run all tests
test:
    Rscript --quiet --vanilla -e 'devtools::test()'

# Run R CMD check
check:
    Rscript --quiet --vanilla -e 'devtools::check()'

# Re-fetch the bundled sample data from BigQuery (needs OP_CREDENTIALS)
build-data:
    Rscript --quiet --vanilla -e 'source("data-raw/sample-data.R")'

# Build pkgdown site
docs-build:
    Rscript --quiet --vanilla -e 'pkgdown::build_site()'

# Preview pkgdown site with HTTP server
docs-serve:
    Rscript --quiet --vanilla -e 'servr::httw("docs", initpath = "index.html", browser = TRUE)'

# Build and preview pkgdown site
docs: docs-build docs-serve
