

#' This function download EIA categories.
#' 
#' @param api_key Character value. Your API key.
#' @param category_id Numerical value. Category.
#' @export
eia_cat <- function(api_key, category_id = NULL){
  
  # parse url
  cat_url <- httr::parse_url(url = "http://api.eia.gov/category/")
  cat_url$query$api_key <- api_key
  cat_url$query$category_id <- category_id
  cat_url$query$out <- "json"
  
  # get data
  cat_data <- httr::GET(url = cat_url)
  cat_data <- httr::content(cat_data, as = "text")
  cat_data <- jsonlite::fromJSON(cat_data)
  
  return(cat_data)
}






