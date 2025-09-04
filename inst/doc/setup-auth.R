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
# # will use the `DEFAULT` profile in `.databrickscfg`
# options(use_databrickscfg = TRUE)
# 
# # values returned should be those in profile of `.databrickscfg`
# db_host()
# db_token()

## -----------------------------------------------------------------------------
# # using .Renviron
# db_host() # returns `DB_HOST` (.Renviron)
# 
# # switch profile to 'prod'
# options(db_profile = "prod")
# db_host() # returns `DB_HOST_PROD` (.Renviron)
# 
# # set back to default (NULL)
# options(db_profile = NULL)
# # use .databrickcfg
# options(use_databrickscfg = TRUE)
# db_host() # returns host from `DEFAULT` profile (.databrickscfg)
# 
# options(db_profile = "prod")
# db_host() # returns host from `prod` profile in (.datarickscfg)

## -----------------------------------------------------------------------------
# library(brickster)
# db_cluster_list()

