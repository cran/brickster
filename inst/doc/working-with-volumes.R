## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)
library(brickster)

## -----------------------------------------------------------------------------
# library(brickster)
# 
# volume_root <- "/Volumes/zacdav/default/data"
# incoming_dir <- file.path(volume_root, "incoming")
# incoming_file <- file.path(incoming_dir, "example.csv")
# 
# # create local file
# local_file <- tempfile(fileext = ".csv")
# write.csv(mtcars, local_file, row.names = FALSE)
# 
# # ensure target directory exists
# db_volume_dir_create(incoming_dir)
# 
# # upload file
# db_volume_write(
#   path = incoming_file,
#   file = local_file,
#   overwrite = TRUE
# )
# 
# # verify + inspect
# db_volume_file_exists(incoming_file)
# db_volume_list(incoming_dir)
# 
# # download file back to local path
# downloaded_file <- tempfile(fileext = ".csv")
# db_volume_read(
#   path = incoming_file,
#   destination = downloaded_file
# )
# 
# # verify that file can be read as csv
# read.csv(downloaded_file)
# 
# # clean up (optional)
# db_volume_delete(incoming_file)
# db_volume_dir_delete(incoming_dir)

## -----------------------------------------------------------------------------
# library(brickster)
# library(arrow)
# library(dplyr)
# 
# volume_root <- "/Volumes/zacdav/default/data"
# landing_dir <- file.path(volume_root, "sample_10m")
# local_dir <- tempfile("arrow_sample_")
# 
# # sample to 10M rows
# # write partitioned Arrow dataset (2 levels deep: cyl/gear)
# mtcars |>
#   sample_n(size = 1e+07, replace = TRUE) |>
#   write_dataset(
#     path = local_dir,
#     format = "parquet",
#     partitioning = c("cyl", "gear")
#   )
# 
# # bulk upload
# db_volume_upload_dir(
#   local_dir = local_dir,
#   volume_dir = landing_dir,
#   overwrite = TRUE,
#   recursive = TRUE
# )
# 
# # bulk download
# local_download <- tempfile("arrow_download_")
# db_volume_download_dir(
#   volume_dir = landing_dir,
#   local_dir = local_download,
#   overwrite = TRUE,
#   recursive = TRUE
# )
# list.files(local_download, recursive = TRUE)
# 
# # cleanup example directory recursively (optional)
# db_volume_dir_delete(
#   path = landing_dir,
#   recursive = TRUE
# )

## -----------------------------------------------------------------------------
# # list volumes in a schema
# db_uc_volumes_list(catalog = "<catalog>", schema = "<schema>")
# 
# # create a managed volume
# db_uc_volumes_create(
#   catalog = "<catalog>",
#   schema = "<schema>",
#   volume = "my_volume",
#   volume_type = "MANAGED"
# )
# 
# # inspect one volume
# db_uc_volumes_get(
#   catalog = "<catalog>",
#   schema = "<schema>",
#   volume = "my_volume"
# )

