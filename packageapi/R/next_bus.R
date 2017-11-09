#' next_bus
#'
#' @return The next bus arrival time, the waiting time and the delay
#' @import jsonlite
#'
#' @export
#'
#' @examples
#'
next_bus <- function() {
  route_id <- readline(prompt ="Enter your route id : ")
  query <- paste("https://applications002.brest-metropole.fr/WIPOD01/Transport/REST/getDestinations?format=json&route_id=",route_id,"", sep = "")
  trip_headsign <- readline(prompt = paste("Chose your direction among this list (",paste(jsonlite::fromJSON(query)$Trip_headsign, collapse = ', '), ") : ", sep = ""))
  trip_headsign <- gsub(" ","%20",trip_headsign)
  new_query <- paste("https://applications002.brest-metropole.fr/WIPOD01/Transport/REST/getStops_route?format=json&route_id=",route_id,"&trip_headsign=",trip_headsign, sep = "")
  stop_name <- readline(prompt = paste("Chose your stop among this list (",paste(jsonlite::fromJSON(new_query)$Stop_name, collapse = ', '), ") : ", sep = ""))
  last_query <- paste("https://applications002.brest-metropole.fr/WIPOD01/Transport/REST/getRemainingTimes?format=json&route_id=",route_id,"&trip_headsign=",trip_headsign,"&stop_name=",stop_name, sep = "")
  arrival <- jsonlite::fromJSON(last_query)$EstimateTime_arrivalRealized[1]
  remaining <- jsonlite::fromJSON(last_query)$Remaining_time[1]
  delay <- jsonlite::fromJSON(last_query)$Delay[1]
  if (delay == 00:00:00) {
    delay_sentence <- "There is no delay."
  } else {
    delay_sentence <- paste("The delay on the schedule is ",delay,".", sep = "")
  }
  sentence <- paste("The next bus will arrive at",arrival,".","You will have to wait", remaining, ".",delay_sentence, sep = " ")
  return(sentence)
}
