## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## ----setup--------------------------------------------------------------------
# library(brickster)
# library(DBI)
# library(dplyr)
# library(dbplyr)
# 
# # Create connection to SQL warehouse
# con <- dbConnect(
#   drv = DatabricksSQL(),
#   warehouse_id = "<your_warehouse_id>",
#   catalog = "samples",
#   show_progress = FALSE
# )

## -----------------------------------------------------------------------------
# trips <- db_sql_query(
#   warehouse_id = "<your_warehouse_id>",
#   statement = "SELECT * FROM samples.nyctaxi.trips LIMIT 10",
#   query_tags = list(team = "informatics", project = "disease_surveillance")
# )

## -----------------------------------------------------------------------------
# con <- dbConnect(
#   DatabricksSQL(),
#   warehouse_id = "<your_warehouse_id>",
#   query_tags = list(team = "informatics", environment = "dev")
# )
# 
# # Uses the connection defaults
# dbGetQuery(con, "SELECT 1")
# 
# # Replaces all defaults for this statement only
# dbGetQuery(con, "SELECT 1", query_tags = list(project = "ad_hoc"))
# 
# # Omits tags for this statement only
# dbGetQuery(con, "SELECT 1", query_tags = NULL)

## -----------------------------------------------------------------------------
# dbGetQuery(con, "
#   SELECT statement_id, statement_text, query_tags
#   FROM system.query.history
#   WHERE query_tags['team'] = 'informatics'
#   ORDER BY start_time DESC
#   LIMIT 20
# ")

## -----------------------------------------------------------------------------
# trips <- dbGetQuery(con, "SELECT * FROM samples.nyctaxi.trips LIMIT 10")

## -----------------------------------------------------------------------------
# # List available tables
# tables <- dbListTables(con)
# 
# # Check if specific table exists
# dbExistsTable(con, "samples.nyctaxi.trips")
# dbExistsTable(con, I("samples.nyctaxi.trips"))
# dbExistsTable(con, Id("samples", "nyctaxi", "trips"))
# 
# # Get column information
# dbListFields(con, "samples.nyctaxi.trips")
# dbListFields(con, I("samples.nyctaxi.trips"))
# dbListFields(con, Id("samples", "nyctaxi", "trips"))

## -----------------------------------------------------------------------------
# # small data (150 rows)
# # creates the table schema explicitly then inserts rows inline
# dbWriteTable(
#   conn = con,
#   name = Id(catalog = "<catalog>", schema = "<schema>", table = "<table>"),
#   value = iris,
#   overwrite = TRUE
# )
# 
# # bigger data (4 million rows)
# # writes parquet files to volume then CTAS
# iris_big <- sample_n(iris, replace = TRUE, size = 4000000)
# 
# dbWriteTable(
#   conn = con,
#   name = Id(catalog = "<catalog>", schema = "<schema>", table = "<table>"),
#   value = iris_big,
#   overwrite = TRUE,
#   staging_volume = "/Volumes/<catalog>/<schema>/<volume>/...", # or inherited from connection
#   show_progress = TRUE
# )
# 

## -----------------------------------------------------------------------------
# # Connect to existing tables
# tbl(con, "samples.nyctaxi.trips")
# tbl(con, I("samples.nyctaxi.trips"))
# tbl(con, Id("samples", "nyctaxi", "trips"))
# tbl(con, in_catalog("samples", "nyctaxi", "trips"))

## -----------------------------------------------------------------------------
# # Filter and select (translated to SQL)
# long_trips <- tbl(con, "samples.nyctaxi.trips") |>
#   filter(trip_distance > 10) |>
#   select(
#     tpep_pickup_datetime,
#     tpep_dropoff_datetime,
#     trip_distance,
#     fare_amount
#   )
# 
# # View the generated SQL (without executing)
# show_query(long_trips)
# 
# # Execute and collect results
# long_trips |> collect()

## -----------------------------------------------------------------------------
# # Customer summary statistics
# trips_summary <- tbl(con, "samples.nyctaxi.trips") |>
#   group_by(pickup_zip) %>%
#   summarise(
#     trip_count = n(),
#     total_fare_amount = sum(fare_amount, na.rm = TRUE),
#     total_trip_distance = sum(trip_distance, na.rm = TRUE),
#     avg_fare_amount = mean(fare_amount, na.rm = TRUE)
#   ) |>
#   arrange(desc(avg_fare_amount))
# 
# # Execute to get the 20 most expensive pickip zip codes with more than 30 trips
# top_zipz <- trips_summary |>
#   filter(trip_count > 20) |>
#   head(20) |>
#   collect()

## -----------------------------------------------------------------------------
# iris_remote <- copy_to(
#   con,
#   iris,
#   "iris_table",
#   temporary = FALSE,
#   overwrite = TRUE
# )

