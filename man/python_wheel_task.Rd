% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data-structures.R
\name{python_wheel_task}
\alias{python_wheel_task}
\title{Python Wheel Task}
\usage{
python_wheel_task(package_name, entry_point = NULL, parameters = list())
}
\arguments{
\item{package_name}{Name of the package to execute.}

\item{entry_point}{Named entry point to use, if it does not exist in the
metadata of the package it executes the function from the package directly
using \verb{$packageName.$entryPoint()}.}

\item{parameters}{Command-line parameters passed to python wheel task.}
}
\description{
Python Wheel Task
}
\seealso{
Other Task Objects: 
\code{\link{condition_task}()},
\code{\link{email_notifications}()},
\code{\link{for_each_task}()},
\code{\link{libraries}()},
\code{\link{new_cluster}()},
\code{\link{notebook_task}()},
\code{\link{pipeline_task}()},
\code{\link{run_job_task}()},
\code{\link{spark_jar_task}()},
\code{\link{spark_python_task}()},
\code{\link{spark_submit_task}()},
\code{\link{sql_file_task}()},
\code{\link{sql_query_task}()}
}
\concept{Task Objects}
