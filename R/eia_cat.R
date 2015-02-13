

#' This function download EIA categories.
#' 
#' @param api_key Character value. Your API key.
#' @param category_id Numerical value. Category.
#' @export
eia_cat <- function(api_key = "34117E2A8A50B13CAC6A3C5C8BDC89CF", category_id = NULL){
  
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


# eia_cat()
# eia_cat(category_id = 0)
# eia_cat(category_id = 714755)
# eia_cat(category_id = 714802)
# eia_cat(category_id = 387912)
# eia_cat(category_id = 387913)
# eia_cat(category_id = 387914)
# eia_cat(category_id = 1238399)
# 
# 






