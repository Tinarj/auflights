# International airline traffic by carrier to and from Australia

Monthly flights, passenger and seat counts for international airlines
operating services to and from Australia, grouped by airline and country
of service, from 2016 onward.

## Usage

``` r
au_int_airlines
```

## Format

Data frame with columns:

- airline:

  Airline name.

- country:

  Country of service

- n_flights_in:

  Number of flights inbound to Australia in the month.

- n_passengers_in:

  Passengers carried inbound to Australia on those flights. For some
  airlines this includes passengers transiting via Australia.

- n_seats_in:

  Available seats inbound to Australia.

- n_flights_out:

  Number of flights outbound from Australia in the month.

- n_passengers_out:

  Passengers carried outbound from Australia.

- year:

  Calendar year.

- month:

  Calendar month (1–12).

## Source

Bureau of Infrastructure and Transport Research Economics (BITRE).
Downloaded from
<https://www.bitre.gov.au/publications/ongoing/international_airline_activity-time_series>.

## Examples

``` r
# Top 10 carriers by total inbound passengers since 2016
au_int_airlines |>
  dplyr::group_by(airline) |>
  dplyr::summarise(total_in = sum(n_passengers_in, na.rm = TRUE)) |>
  dplyr::arrange(dplyr::desc(total_in)) |>
  dplyr::slice_head(n = 10)
#> # A tibble: 10 × 2
#>    airline                total_in
#>    <chr>                     <dbl>
#>  1 Qantas Airways         27376794
#>  2 Jetstar                15181678
#>  3 Singapore Airlines     13468058
#>  4 Emirates               11589878
#>  5 Air New Zealand        10589764
#>  6 Virgin Australia        7299346
#>  7 Cathay Pacific Airways  5980570
#>  8 Qatar Airways           4769969
#>  9 AirAsia X               4113463
#> 10 Malaysia Airlines       3881610
```
