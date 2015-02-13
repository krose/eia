#' This function download series data.
#' 
#' @param api_key Character value. Your API key.
#' @param series_id Character vector. Name of series.
#' @param num Numerical. Optional. Cannot be used with start and end. Maximum number of most recent points returned.
#' @param start Character. Optional. Same format as values returned. 
#'   Dates are formatted as yyyy, yyyyQq, yyyymm, yyyymmdd for annual, quarterly, monthly, and daily/weekly data respectively.
#' @param end Character. Optional. Same format as values returned. 
#'   Dates are formatted as yyyy, yyyyQq, yyyymm, yyyymmdd for annual, quarterly, monthly, and daily/weekly data respectively.
#' @param num Numerical. Optional. Cannot be used with start and end. Maximum number of most recent points returned.
#' @param tidy_data Select between "no", "tidy_long". If true, there will be added two variables; the series_name and series_time_frame.
#' @param Logical. Return only the data and not meta data?
#' 
#' @export
#' @import magrittr
eia_series <- function(api_key, series_id, start = NULL, end = NULL, num = NULL, tidy_data = "no", only_data = FALSE){
  # max 100 series
  # test if num is not null and either start or end is nut null. Not allowed
  # api_key test for character.
  # series_id test for character.
  # if start/end not null, then check if format matches series id date format
  # parse date and numerical data
  
  # parse url
  series_url <- httr::parse_url("http://api.eia.gov/series/")
  series_url$query$series_id <- paste(series_id, collapse = ";")
  series_url$query$api_key <- api_key
  series_url$query$start <- start
  series_url$query$end <- end
  series_url$query$num <- num
  
  # get data
  series_data <- httr::GET(url = series_url)
  series_data <- httr::content(series_data, as = "text")
  series_data <- jsonlite::fromJSON(series_data)
  
  # Move data from data.frame with nested list and NULL excisting
  series_data$data <- series_data$series$data
  series_data$series$data <- NULL
  
  # parse data
  series_data$data <- lapply(X = series_data$data, 
                             FUN = function(x) data.frame(date = x[, 1], 
                                                          value = as.numeric(x[, 2]), 
                                                          stringsAsFactors = FALSE))
  
  # add names to the list with data
  names(series_data$data) <- series_data$data
  
  # parse dates
  series_data$data <- eia_date_parse(series_list = series_data$data, format_character = series_data$series$f)
  
  # tidy up data
  if(tidy_data == "tidy_long"){
    
    series_data$data <- lapply(seq_along(series_data$data), 
                                      function(x) {cbind(series_data$data[[x]], 
                                                         series_time_frame = series_data$series$f[x],
                                                         series_name = series_data$series$series_id[x], 
                                                         stringsAsFactors = FALSE)})
    series_data$data <- do.call(rbind, series_data$data)
  } 
  
  # only data
  if(only_data){
    series_data <- series_data$data
  }
  
  return(series_data)
}

