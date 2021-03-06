% Generated by roxygen2 (4.0.1): do not edit by hand
\name{eia_series}
\alias{eia_series}
\title{This function download series data.}
\usage{
eia_series(api_key = "34117E2A8A50B13CAC6A3C5C8BDC89CF", series_id,
  start = NULL, end = NULL, num = NULL, tidy_data = "no",
  only_data = FALSE)
}
\arguments{
\item{api_key}{Character value. Your API key.}

\item{series_id}{Character vector. Name of series.}

\item{num}{Numerical. Optional. Cannot be used with start and end. Maximum number of most recent points returned.}

\item{start}{Character. Optional. Same format as values returned.
Dates are formatted as yyyy, yyyyQq, yyyymm, yyyymmdd for annual, quarterly, monthly, and daily/weekly data respectively.}

\item{end}{Character. Optional. Same format as values returned.
Dates are formatted as yyyy, yyyyQq, yyyymm, yyyymmdd for annual, quarterly, monthly, and daily/weekly data respectively.}

\item{num}{Numerical. Optional. Cannot be used with start and end. Maximum number of most recent points returned.}

\item{tidy_data}{Select between "no", "tidy_long". If true, there will be added two variables; the series_name and series_time_frame.}

\item{Logical.}{Return only the data and not meta data?}
}
\description{
This function download series data.
}

