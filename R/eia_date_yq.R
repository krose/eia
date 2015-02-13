
#' A function to parse quarterly dates from EIA
#' 
#' @param qstr Character vector with the EIA format yyyyQq
#' @param fist Logical. Returns either the first or the last date in the quarter.
eia_date_yq <- function(qstr, first = TRUE)
{
  pattern <- "\\<((?:[0-9]{2}){1,2})[qQ]([0-9])\\>"
  if (grepl(pattern, qstr) %>% 
        `n'est pas` %>% 
        any)
    stop("Input string is not in the right format.", call. = FALSE)
  
  years    <- gsub(pattern, "\\1", qstr) 
  quarters <- gsub(pattern, "\\2", qstr) %>% as.numeric
  months   <- ((quarters - 1)*4 + 1 )
  
  date_format <- ifelse(nchar(years) == 2, "%y %m %d", "%Y %m %d")
  
  result   <- paste(years, months, 1) %>% as.Date(date_format)
  
  if (first)
    result
  else 
    result %>% 
    lapply(. %>% 
             seq(by = "month", length.out = 4) %>%
             extract(4) %>% 
             subtract(1)) %>% 
    do.call(what = c)
}


