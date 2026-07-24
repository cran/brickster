## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## ----setup--------------------------------------------------------------------
# library(brickster)
# 
# # using db_host() and db_token() to get credentials
# clusters <- db_cluster_list(host = db_host(), token = db_token())

## -----------------------------------------------------------------------------
# # all host/token parameters default to db_host()/db_token()
# clusters <- db_cluster_list()

## -----------------------------------------------------------------------------
# # uses the CLI-selected default profile, or `DEFAULT` when none is selected
# options(use_databrickscfg = TRUE)
# 
# # values are read from `.databrickscfg`
# db_host()
# db_token()

## -----------------------------------------------------------------------------
# # using .Renviron
# db_host() # returns `DATABRICKS_HOST` (.Renviron)
# 
# # switch profile to 'prod'
# options(db_profile = "prod")
# db_host() # returns `DATABRICKS_HOST_PROD` (.Renviron)
# 
# # clear the session-specific profile selection
# options(db_profile = NULL)
# # use .databrickscfg
# options(use_databrickscfg = TRUE)
# db_host() # returns the CLI-selected default, otherwise `DEFAULT` (.databrickscfg)
# 
# options(db_profile = "prod")
# db_host() # returns host from `prod` profile (.databrickscfg)

## -----------------------------------------------------------------------------
# options(
#   use_databrickscfg = TRUE,
#   db_profile = "e2-demo"
# )
# 
# # The host and CLI token are resolved from the same profile.
# db_sql_warehouse_list()

## -----------------------------------------------------------------------------
# library(brickster)
# db_cluster_list()

