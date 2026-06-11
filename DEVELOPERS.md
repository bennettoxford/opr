# NA

## Development

Common tasks are available via [just](https://github.com/casey/just),
see the `justfile`:

``` bash
just document   # roxygen documentation
just test       # run tests
just check      # R CMD check
just fix        # format R code with air
just docs       # build and preview the pkgdown site
just build-data # re-fetch the bundled sample data from BigQuery
```

Tests run against an in-memory [duckdb](https://duckdb.org/) database
and bundled sample data, so no BigQuery credentials are needed for
development.
