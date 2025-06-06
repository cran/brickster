db_uc_metastore_summary <- function(host = db_host(), token = db_token(),
                                    perform_request = TRUE) {

  req <- db_request(
    endpoint = "unity-catalog/metastore_summary",
    method = "GET",
    version = "2.1",
    host = host,
    token = token
  )

  if (perform_request) {
    db_perform_request(req)
  } else {
    req
  }
}

db_uc_storage_creds_list <- function(host = db_host(), token = db_token(),
                                    perform_request = TRUE) {

  req <- db_request(
    endpoint = "unity-catalog/storage-credentials",
    method = "GET",
    version = "2.1",
    host = host,
    token = token
  )

  if (perform_request) {
    db_perform_request(req)
  } else {
    req
  }
}


db_uc_storage_creds_get <- function(name,
                                    host = db_host(), token = db_token(),
                                    perform_request = TRUE) {

  body <- list(
    name = name
  )

  req <- db_request(
    endpoint = "unity-catalog/storage-credentials",
    method = "GET",
    version = "2.1",
    body = body,
    host = host,
    token = token
  ) |>
    httr2::req_url_path_append(name)

  if (perform_request) {
    db_perform_request(req)
  } else {
    req
  }
}

db_uc_external_loc_list <- function(host = db_host(), token = db_token(),
                                     perform_request = TRUE) {

  req <- db_request(
    endpoint = "unity-catalog/external-locations",
    method = "GET",
    version = "2.1",
    host = host,
    token = token
  )

  if (perform_request) {
    db_perform_request(req)
  } else {
    req
  }
}


db_uc_external_loc_get <- function(name,
                                    host = db_host(), token = db_token(),
                                    perform_request = TRUE) {


  req <- db_request(
    endpoint = "unity-catalog/external-locations/",
    method = "GET",
    version = "2.1",
    host = host,
    token = token
  ) |>
    httr2::req_url_path_append(name)

  if (perform_request) {
    db_perform_request(req)
  } else {
    req
  }
}




db_uc_models_list <- function(catalog, schema,
                              host = db_host(), token = db_token(),
                              perform_request = TRUE) {

  req <- db_request(
    endpoint = "unity-catalog/models",
    method = "GET",
    version = "2.1",
    host = host,
    token = token
  ) |>
    httr2::req_url_query(
      catalog_name = catalog,
      schema_name = schema,
      include_browse = 'true'
    )

  if (perform_request) {
    db_perform_request(req)$registered_models
  } else {
    req
  }
}


db_uc_models_get <- function(catalog, schema, model,
                             host = db_host(), token = db_token(),
                             perform_request = TRUE) {

  req <- db_request(
    endpoint = "unity-catalog/models",
    method = "GET",
    version = "2.1",
    host = host,
    token = token
  ) |>
    httr2::req_url_path_append(paste(catalog, schema, model, sep = ".")) |>
    httr2::req_url_query(include_aliases = 'true')

  if (perform_request) {
    db_perform_request(req)
  } else {
    req
  }
}


db_uc_model_versions_get <- function(catalog, schema, model,
                             host = db_host(), token = db_token(),
                             perform_request = TRUE) {

  req <- db_request(
    endpoint = "unity-catalog/models",
    method = "GET",
    version = "2.1",
    host = host,
    token = token
  ) |>
    httr2::req_url_path_append(paste(catalog, schema, model, sep = ".")) |>
    httr2::req_url_path_append("versions") |>
    httr2::req_url_query(max_results = 1000)

  if (perform_request) {
    db_perform_request(req)
  } else {
    req
  }
}

db_uc_funcs_list <- function(catalog, schema,
                              host = db_host(), token = db_token(),
                              perform_request = TRUE) {

  req <- db_request(
    endpoint = "unity-catalog/functions",
    method = "GET",
    version = "2.1",
    host = host,
    token = token
  ) |>
    httr2::req_url_query(
      catalog_name = catalog,
      schema_name = schema
    )

  if (perform_request) {
    db_perform_request(req)$functions
  } else {
    req
  }
}


db_uc_funcs_get <- function(catalog, schema, func,
                             host = db_host(), token = db_token(),
                             perform_request = TRUE) {

  req <- db_request(
    endpoint = "unity-catalog/functions",
    method = "GET",
    version = "2.1",
    host = host,
    token = token
  ) |>
    httr2::req_url_path_append(paste(catalog, schema, func, sep = "."))

  if (perform_request) {
    db_perform_request(req)
  } else {
    req
  }
}
