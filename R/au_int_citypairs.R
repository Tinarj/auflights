#' International airline flights and seats by airline, route and city pair
#'
#' @description
#' Monthly scheduled international passenger flights and seats
#' operated to and from Australia, broken down by airline, route and
#' Australian–foreign city pair. In this package the data are restricted to
#' calendar years 2016 onwards.
#'
#' @format Data frame with columns:
#' \describe{
#'   \item{australian}{Name of the Australian city.}
#'   \item{international}{Name of the overseas city.}
#'   \item{airline}{Operating airline.}
#'   \item{route}{Full route string for the flight number.}
#'   \item{port_country}{Country of the international port.}
#'   \item{port_region}{Geographic region of the international port.}
#'   \item{service_country}{“Country of service” – international country
#'     where the same–flight–number service originates or terminates.}
#'   \item{service_region}{Region corresponding to `service_country`.}
#'   \item{stops}{Number of intermediate stops on the route for this
#'     city pair. `0` indicates “over the coast” (directly connected)
#'     services.}
#'   \item{all_flights}{Number of flights operated on the route that are
#'     available to this city pair under the “all flights” definition.}
#'   \item{max_seats}{Maximum number of seats associated
#'     with `all_flights` for this city pair.}
#'   \item{in_out}{Direction of service relative to Australia:
#'     `"I"` = inbound to Australia, `"O"` = outbound from Australia.}
#'   \item{year}{Calendar year.}
#'   \item{month}{Calendar month as an integer from 1 (January) to 12
#'     (December).}
#' }
#'
#' @source
#' Bureau of Infrastructure and Transport Research Economics (BITRE), downloaded from:
#' <https://www.bitre.gov.au/publications/ongoing/international_airline_activity-time_series>.
#' @seealso
#' [au_int_routes] for passenger movements by international city pair.
#'
#' @examples
#' au_int_citypairs |>
#' dplyr::filter(in_out == "I", stops == 0) |>
#' dplyr::group_by(airline) |>
#' dplyr::summarise(total_seats = sum(max_seats, na.rm = TRUE), .groups = "drop") |>
#' dplyr::arrange(desc(total_seats)) |>
#' dplyr::slice_head(n = 10)
#'
"au_int_citypairs"
