#' stop_line
#'
#' @param line_id is a string (the line_id)
#' @return the stops of a line
#'
#' @import jsonlite
#'
#' @export
#'
#' @examples

stop_line <- function(route_id) {
  query <- paste("https://applications002.brest-metropole.fr/WIPOD01/Transport/REST/getDestinations?format=json&route_id=",route_id,"", sep = "")
  headsigns <-jsonlite::fromJSON(query)
  headsigns_list <- gsub(" ","%20",headsigns$Trip_headsign)
  liste <- lapply(FUN = paste, "https://applications002.brest-metropole.fr/WIPOD01/Transport/REST/getStops_route?format=json&route_id=",route_id,"&trip_headsign=", headsigns_list, sep = "")
  stops_list <- lapply(liste[[1]], FUN = jsonlite::fromJSON)
  return(unique(Reduce(rbind, stops_list)$Stop_name))
}

