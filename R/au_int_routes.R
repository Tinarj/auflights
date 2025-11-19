#' International airline city-pair passengers to and from Australia
#'
#' @description
#' Monthly inbound and outbound passenger counts on international
#' city-pair routes between Australian airports and overseas cities,
#' from 2016 onward.
#'
#' @format Data frame with columns:
#' \describe{
#'   \item{origin_city}{Name of the Australian city/airport.}
#'   \item{dest_city}{Name of the overseas city/airport.}
#'   \item{dest_country}{Destination country for the overseas airport.}
#'   \item{n_passengers_in}{Number of revenue passengers arriving in Australia
#'     on the route in the given month.}
#'   \item{n_passengers_out}{Number of revenue passengers departing Australia
#'     on the route in the given month.}
#'   \item{year}{Calendar year.}
#'   \item{month}{Calendar month.}
#' }
#'
#' @source Bureau of Infrastructure and Transport Research Economics (BITRE).
#'   Downloaded from
#'  <https://www.bitre.gov.au/publications/ongoing/international_airline_activity-time_series>.
#'
#' @examples
#' # Top 10 total inbound passengers by country
#' au_int_routes |>
#' dplyr::group_by(dest_country) |>
#' dplyr::summarise(total_in = sum(n_passengers_in, na.rm = TRUE)) |>
#' dplyr::arrange(desc(total_in)) |>
#' dplyr::slice_head(n = 10)
#'
"au_int_routes"
