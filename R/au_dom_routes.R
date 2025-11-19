#' Monthly top domestic routes in Australia
#'
#' @description
#' Monthly traffic on the busiest domestic airline routes in Australia,
#' including passengers, flights and seats by origin–destination pair.
#' Data cover revenue (paying) passengers on regular public transport (RPT)
#' services from 2016 onward.
#'
#' @format Data frame with columns:
#' \describe{
#'   \item{origin_airport}{Three-letter IATA code of the origin airport
#'     (e.g. "SYD" for Sydney).}
#'   \item{dest_airport}{Three-letter IATA code of the destination airport
#'     (e.g. "MEL" for Melbourne).}
#'   \item{origin_city}{Name of the origin city (e.g. `"Sydney"`).}
#'   \item{dest_city}{Name of the destination city (e.g. `"Melbourne"`).}
#'   \item{year}{Calendar year, e.g. 2016.}
#'   \item{month}{Calendar month 1–12 (1 = January, 12 = December).}
#'   \item{n_passengers}{Number of revenue (paying) passengers carried on the
#'     route in that month, both directions combined.}
#'   \item{n_flights}{Number of aircraft trips (flights) operated on the route
#'     in that month.}
#'   \item{n_seats}{Total number of seats offered on flights on the route
#'     in that month (capacity).}
#' }
#'
#' @source
#' Bureau of Infrastructure and Transport Research Economics (BITRE),
#' \emph{Domestic aviation statistics – Top routes}.
#' Data downloaded from \url{https://www.bitre.gov.au/publications/ongoing/domestic_airline_activity-time_series}.
#'
#' @examples
#' au_dom_routes
"au_dom_routes"
