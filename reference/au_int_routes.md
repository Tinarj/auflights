# International airline city-pair passengers to and from Australia

Monthly inbound and outbound passenger counts on international city-pair
routes between Australian airports and overseas cities, from 2016
onward.

## Usage

``` r
au_int_routes
```

## Format

Data frame with columns:

- origin_city:

  Name of the Australian city/airport.

- dest_city:

  Name of the overseas city/airport.

- dest_country:

  Destination country for the overseas airport.

- n_passengers_in:

  Number of revenue passengers arriving in Australia on the route in the
  given month.

- n_passengers_out:

  Number of revenue passengers departing Australia on the route in the
  given month.

- year:

  Calendar year.

- month:

  Calendar month.

## Source

Bureau of Infrastructure and Transport Research Economics (BITRE).
Downloaded from
<https://www.bitre.gov.au/publications/ongoing/international_airline_activity-time_series>.

## Examples

``` r
# Top 10 total inbound passengers by country
au_int_routes |>
dplyr::group_by(dest_country) |>
dplyr::summarise(total_in = sum(n_passengers_in, na.rm = TRUE)) |>
dplyr::arrange(desc(total_in)) |>
dplyr::slice_head(n = 10)
#> # A tibble: 10 × 2
#>    dest_country         total_in
#>    <chr>                   <dbl>
#>  1 New Zealand          26657876
#>  2 Singapore            23188329
#>  3 Indonesia            13330385
#>  4 United Arab Emirates 13124085
#>  5 USA                  11097421
#>  6 China                10659929
#>  7 Hong Kong (SAR)       8643434
#>  8 Malaysia              8604349
#>  9 Thailand              5803042
#> 10 Japan                 5652710
```
