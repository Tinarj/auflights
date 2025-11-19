# International airline flights and seats by airline, route and city pair

Monthly scheduled international passenger flights and seats operated to
and from Australia, broken down by airline, route and Australian–foreign
city pair. In this package the data are restricted to calendar years
2016 onwards.

## Usage

``` r
au_int_citypairs
```

## Format

Data frame with columns:

- australian:

  Name of the Australian city.

- international:

  Name of the overseas city.

- airline:

  Operating airline.

- route:

  Full route string for the flight number.

- port_country:

  Country of the international port.

- port_region:

  Geographic region of the international port.

- service_country:

  “Country of service” – international country where the
  same–flight–number service originates or terminates.

- service_region:

  Region corresponding to `service_country`.

- stops:

  Number of intermediate stops on the route for this city pair. `0`
  indicates “over the coast” (directly connected) services.

- all_flights:

  Number of flights operated on the route that are available to this
  city pair under the “all flights” definition.

- max_seats:

  Maximum number of seats associated with `all_flights` for this city
  pair.

- in_out:

  Direction of service relative to Australia: `"I"` = inbound to
  Australia, `"O"` = outbound from Australia.

- year:

  Calendar year.

- month:

  Calendar month as an integer from 1 (January) to 12 (December).

## Source

Bureau of Infrastructure and Transport Research Economics (BITRE),
downloaded from:
<https://www.bitre.gov.au/publications/ongoing/international_airline_activity-time_series>.

## See also

[au_int_routes](https://tinarj.github.io/auflights/reference/au_int_routes.md)
for passenger movements by international city pair.

## Examples

``` r
au_int_citypairs |>
dplyr::filter(in_out == "I", stops == 0) |>
dplyr::group_by(airline) |>
dplyr::summarise(total_seats = sum(max_seats, na.rm = TRUE), .groups = "drop") |>
dplyr::arrange(desc(total_seats)) |>
dplyr::slice_head(n = 10)
#> # A tibble: 10 × 2
#>    airline                total_seats
#>    <chr>                        <dbl>
#>  1 Qantas Airways            32626584
#>  2 Jetstar                   17526766
#>  3 Singapore Airlines        16473008
#>  4 Emirates                  15290777
#>  5 Air New Zealand           13123155
#>  6 Virgin Australia           9554486
#>  7 Cathay Pacific Airways     7492084
#>  8 Qatar Airways              6431509
#>  9 AirAsia X                  5352646
#> 10 Malaysia Airlines          4842279
```
