#' stop_line
#'
#' @param line_id is a string (the line_id)
#' @param destination is a string (the destination)
#' @return the stops of a line
#'
#' @import jsonlite
#'
#' @export
#'
#' @examples

stop_line <- function(line_id,destination) {
    apiurl <- paste('https://applications002.brest-metropole.fr/WIPOD01/Transport/REST/getStops_route?format=json&route_id=',line_id,'&trip_headsign=',destination, sep="")
    data <- jsonlite::fromJSON(apiurl)
    data$Stop_name
}
