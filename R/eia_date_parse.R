

#' A function to parse dates from series
#'
#' @param series_list A list of requested series.
#' @param format_character A vector with a character defining the date formats
eia_date_parse <- function(series_list, format_character){
  
  # Stop if the vector of date formats is not equal to the length of the series_list
  stopifnot(length(series_list) == length(format_character))
  
  # Loop through the date format definations and list with data and format the dates
  for(i in 1:length(format_character)){
    
    if(format_character[i] == "A"){  # Parse yearly dates
      series_list[[i]]$date <- strptime(x = paste0(series_list[[i]]$date, "0101"), format = "%Y%m%d", tz = "GMT") %>% as.POSIXct
    } else if(format_character[i] == "Q"){ # Parse quarterly dates with helper function
      series_list[[i]]$date <- eia_date_yq(series_list[[i]]$date, first = TRUE) %>% as.POSIXct
    } else if(format_character[i] == "M"){ # Parse monthly dates
      series_list[[i]]$date <- strptime(x = paste0(series_list[[i]]$date, "01"), format = "%Y%m%d", tz = "GMT") %>% as.POSIXct
    } else if(format_character[i] == "W"){ # Parse Weekly dates
      series_list[[i]]$date <- strptime(series_list[[i]]$date, format = "%Y%m%d", tz = "GMT") %>% as.POSIXct
    } else if(format_character[i] == "D"){ # Parse Daily dates
      series_list[[i]]$date <- strptime(series_list[[i]]$date, format = "%Y%m%d", tz = "GMT") %>% as.POSIXct
    } else {
      warning("One or more of the series have unrecognized date formats")
    }
  
  }
  
  return(series_list)
}


