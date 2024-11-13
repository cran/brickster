## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## ----setup--------------------------------------------------------------------
#  library(brickster)
#  
#  # create a small cluster on AWS with DBR 9.1 LTS
#  new_cluster <- db_cluster_create(
#    name = "brickster-cluster",
#    spark_version = "9.1.x-scala2.12",
#    num_workers = 2,
#    node_type_id = "m5a.xlarge",
#    cloud_attrs = aws_attributes(
#      ebs_volume_count = 3,
#      ebs_volume_size = 100
#    )
#  )

## ----echo=FALSE, results='hide'-----------------------------------------------
#  temp <- get_and_start_cluster(cluster_id = new_cluster$cluster_id)

## -----------------------------------------------------------------------------
#  cluster_info <- db_cluster_get(cluster_id = new_cluster$cluster_id)
#  cluster_info$state

## ----results='hide'-----------------------------------------------------------
#  
#  # we are required to input all parameters
#  db_cluster_edit(
#    cluster_id = new_cluster$cluster_id,
#    name = "brickster-cluster",
#    spark_version = "9.1.x-scala2.12",
#    node_type_id = "m5a.xlarge",
#    autoscale = cluster_autoscale(min_workers = 2, max_workers = 8),
#    cloud_attrs = aws_attributes(
#      ebs_volume_count = 3,
#      ebs_volume_size = 100
#    ),
#    custom_tags = list(
#      purpose = "brickster_cluster_demo"
#    )
#  )

## ----results='hide'-----------------------------------------------------------
#  # adjust number autoscale range to be between 4-6 workers
#  db_cluster_resize(
#    cluster_id = new_cluster$cluster_id,
#    autoscale = cluster_autoscale(min_workers = 4, max_workers = 6)
#  )

## ----results='hide'-----------------------------------------------------------
#  # pin the cluster
#  db_cluster_pin(cluster_id = new_cluster$cluster_id)
#  
#  # unpin the cluster
#  # db_cluster_unpin(cluster_id = new_cluster$cluster_id)

## ----results='hide'-----------------------------------------------------------
#  # installing a package from CRAN on cluster
#  db_libs_install(
#    cluster_id = new_cluster$cluster_id,
#    libraries = libraries(
#      lib_cran(package = "palmerpenguins"),
#      lib_cran(package = "dplyr")
#    )
#  )

## ----results='hide'-----------------------------------------------------------
#  wait_for_lib_installs(cluster_id = new_cluster$cluster_id)

## -----------------------------------------------------------------------------
#  db_libs_cluster_status(cluster_id = new_cluster$cluster_id)

## ----results='hide'-----------------------------------------------------------
#  db_libs_uninstall(
#    cluster_id = new_cluster$cluster_id,
#    libraries = libraries(
#      lib_cran(package = "palmerpenguins")
#    )
#  )

## -----------------------------------------------------------------------------
#  db_libs_cluster_status(cluster_id = new_cluster$cluster_id)

## -----------------------------------------------------------------------------
#  events <- db_cluster_events(cluster_id = new_cluster$cluster_id)
#  head(events, 1)

## ----echo=FALSE, results='hide'-----------------------------------------------
#  db_cluster_unpin(cluster_id = new_cluster$cluster_id)
#  db_cluster_perm_delete(cluster_id = new_cluster$cluster_id)

