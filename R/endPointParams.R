# This function defines common methods for connecting to the Survos API endpoints,
# extracting initial data, then looping through all available pages if required.

endPointParams <- function(endPointExt, endPointPages){
  
  # Define funcOps or it won't be found
  #funcOps <- NULL

  # This first part is really only required so we know the total number of pages
  
  message("Counting pages...")
  flush.console()
  
  url <- paste(endPoint, endPointExt, funcOps, sep="")
  
  getData <- httr::GET(url=url, add_headers(Authorization=paste("Bearer ", accessToken, sep="")))
  
  dataReturn <- jsonlite::fromJSON(content(getData,type="text"))
  
  # Everything below here deals with returning data across all pages. 
  
  for (i in 1:dataReturn$pages) { 
    
    url[i] <- as.list(paste(endPoint, endPointExt, funcOps, endPointPages, i,sep=""))

  }
  
  numberPages <- length(url)
  message(paste("Total Pages: ", numberPages, sep=""))
  flush.console()
  message("Data Retrieval Progress:")
  flush.console()
  
  # Iterate through all URLs, error check for correct status code from API return and print a projess bar.
  
 getData <- llply(url, function(x) httr::GET(url=x, add_headers(Authorization=paste("Bearer ", accessToken, sep=""))) , .progress = "text" )
 
 if (httr::status_code(getData[[1]]) != "200") {
   stop("Status Code: ", httr::status_code(getData[[1]]), " Something went wrong. Please check URL validity. ", url[1])
 } else {

 dataReturn <- lapply(getData, function(x) jsonlite::fromJSON(content(x,type="text", flatten = TRUE)))
  
  lapply(dataReturn, '[[', 'items' )
 }
  
}