## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)
library(brickster)

## ----include = FALSE----------------------------------------------------------
#  # # create a notebook for job examples
#  # # make dir on databricks workspace
#  # db_workspace_mkdirs("/brickster")
#  # files <- db_workspace_list("/brickster/")
#  # files <- sapply(files, function(x) x$path)
#  #
#  # if (!"/brickster/simple-notebook" %in% files) {
#  #   # temp dir to create notebook locally
#  #   temp_dir <- tempdir()
#  #
#  #   # make notebook locally
#  #   path <- file.path(temp_dir, "simple-notebook.r")
#  #   writeLines(text = "print('hello world')", con = path)
#  #
#  #   # import to workspace
#  #   db_workspace_import(
#  #     path = "/brickster/simple-notebook",
#  #     file = path,
#  #     format = "SOURCE",
#  #     language = "R"
#  #   )
#  # }

## -----------------------------------------------------------------------------
#  # list all jobs within Databricks workspace
#  # can control limit, offset, and if cluster/jobs details are returned
#  jobs <- db_jobs_list(limit = 10)
#  
#  # list all runs within a specific job
#  job_runs <- db_jobs_runs_list(job_id = jobs[[1]]$job_id)

## -----------------------------------------------------------------------------
#  # details of a specific job
#  job_details <- db_jobs_get(job_id = jobs[[1]]$job_id)

## -----------------------------------------------------------------------------
#  # define a job task
#  simple_task <- job_task(
#    task_key = "simple_task",
#    description = "a simple task that runs a notebook",
#    # specify a cluster for the job
#    new_cluster = new_cluster(
#      spark_version = "16.4.x-scala2.12",
#      driver_node_type_id = "m5a.large",
#      node_type_id = "m5a.large",
#      num_workers = 2,
#      cloud_attr = aws_attributes(ebs_volume_size = 32)
#    ),
#    # this task will be a notebook
#    task = notebook_task(notebook_path = "/brickster/simple-notebook")
#  )

## -----------------------------------------------------------------------------
#  # create job with simple task
#  simple_task_job <- db_jobs_create(
#    name = "brickster example: simple",
#    tasks = job_tasks(simple_task),
#    # 9am every day, paused currently
#    schedule = cron_schedule(
#      quartz_cron_expression = "0 0 9 * * ?",
#      pause_status = "PAUSED"
#    )
#  )

## -----------------------------------------------------------------------------
#  # one cluster definition, repeatedly use for each task
#  multitask_cluster <- new_cluster(
#    spark_version = "16.4.x-scala2.12",
#    driver_node_type_id = "m5a.large",
#    node_type_id = "m5a.large",
#    num_workers = 2,
#    cloud_attr = aws_attributes(ebs_volume_size = 32)
#  )
#  
#  # each task will run the same notebook (just for this example)
#  multitask_task <- notebook_task(notebook_path = "/brickster/simple-notebook")
#  
#  # create three simple tasks that will depend on each other
#  # task_a -> task_b -> task_c
#  task_a <- job_task(
#    task_key = "task_a",
#    description = "First task in the sequence",
#    new_cluster = multitask_cluster,
#    task = multitask_task
#  )
#  
#  task_b <- job_task(
#    task_key = "task_b",
#    description = "Second task in the sequence",
#    new_cluster = multitask_cluster,
#    task = multitask_task,
#    depends_on = "task_a"
#  )
#  
#  task_c <- job_task(
#    task_key = "task_c",
#    description = "Third task in the sequence",
#    new_cluster = multitask_cluster,
#    task = multitask_task,
#    depends_on = "task_b"
#  )

## -----------------------------------------------------------------------------
#  # create job with multiple tasks
#  multitask_job <- db_jobs_create(
#    name = "brickster example: multi-task",
#    tasks = job_tasks(task_a, task_b, task_c),
#    # 9am every day, paused currently
#    schedule = cron_schedule(
#      quartz_cron_expression = "0 0 9 * * ?",
#      pause_status = "PAUSED"
#    )
#  )

## -----------------------------------------------------------------------------
#  # create three simple tasks that will depend on each other
#  # this time we will use a shared cluster to reduce startup overhead
#  # task_a -> task_b -> task_c
#  task_a <- job_task(
#    task_key = "task_a",
#    description = "First task in the sequence",
#    job_cluster_key = "shared_cluster",
#    task = multitask_task
#  )
#  
#  task_b <- job_task(
#    task_key = "task_b",
#    description = "Second task in the sequence",
#    job_cluster_key = "shared_cluster",
#    task = multitask_task,
#    depends_on = "task_a"
#  )
#  
#  task_c <- job_task(
#    task_key = "task_c",
#    description = "Third task in the sequence",
#    job_cluster_key = "shared_cluster",
#    task = multitask_task,
#    depends_on = "task_b"
#  )

## -----------------------------------------------------------------------------
#  # define job_clusters as a named list of new_cluster()
#  multitask_job_with_reuse <- db_jobs_create(
#    name = "brickster example: multi-task with reuse",
#    job_clusters = list("shared_cluster" = multitask_cluster),
#    tasks = job_tasks(task_a, task_b, task_c),
#    # 9am every day, paused currently
#    schedule = cron_schedule(
#      quartz_cron_expression = "0 0 9 * * ?",
#      pause_status = "PAUSED"
#    )
#  )

## -----------------------------------------------------------------------------
#  # submit a one off job run
#  # reuse the simple task from first example
#  # idempotency_token guarentees no additional triggers
#  oneoff_job <- db_jobs_runs_submit(
#    tasks = job_tasks(simple_task),
#    run_name = "brickster example: one-off job",
#    idempotency_token = "my_job_run_token"
#  )

## -----------------------------------------------------------------------------
#  # define a job task
#  # this time, the notebook_path is relative to the git root directory
#  # omit file extensions like .py or .r
#  simple_task <- job_task(
#    task_key = "simple_task",
#    description = "a simple task that runs a notebook",
#    # specify a cluster for the job
#    new_cluster = new_cluster(
#      spark_version = "16.4.x-scala2.12",
#      driver_node_type_id = "m5a.large",
#      node_type_id = "m5a.large",
#      num_workers = 2,
#      cloud_attr = aws_attributes(ebs_volume_size = 32)
#    ),
#    # this task will be a notebook
#    task = notebook_task(notebook_path = "example/simple-notebook")
#  )

## -----------------------------------------------------------------------------
#  # create job with simple task
#  simple_task_job <- db_jobs_create(
#    name = "brickster example: simple",
#    tasks = job_tasks(simple_task),
#    # git source points to repo
#    git_source = git_source(
#      git_url = "www.github.com/<user>/<repo>",
#      git_provider = "github",
#      reference = "main",
#      type = "branch"
#    ),
#    # 9am every day, paused currently
#    schedule = cron_schedule(
#      quartz_cron_expression = "0 0 9 * * ?",
#      pause_status = "PAUSED"
#    )
#  )

## ----results = FALSE----------------------------------------------------------
#  # only change the job name
#  db_jobs_update(
#    job_id = multitask_job_with_reuse$job_id,
#    name = "brickster example: renamed job"
#  )

## ----results = FALSE----------------------------------------------------------
#  # adding timeout and increasing max concurrent runs
#  db_jobs_update(
#    job_id = multitask_job_with_reuse$job_id,
#    timeout_seconds = 60 * 5,
#    max_concurrent_runs = 2
#  )

## -----------------------------------------------------------------------------
#  # invoke simple job example
#  triggered_run <- db_jobs_run_now(job_id = simple_task_job$job_id)

## ----results = FALSE----------------------------------------------------------
#  # cancel run whilst it is in progress
#  db_jobs_runs_cancel(run_id = triggered_run$run_id)

## ----results = FALSE----------------------------------------------------------
#  db_jobs_delete(job_id = simple_task_job$job_id)
#  db_jobs_delete(job_id = multitask_job$job_id)
#  db_jobs_delete(job_id = multitask_job_with_reuse$job_id)

## ----cleanup, include = FALSE-------------------------------------------------
#  # db_workspace_delete("/brickster/simple-notebook")

