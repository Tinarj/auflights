# Monthly top domestic routes in Australia

Monthly traffic on the busiest domestic airline routes in Australia,
including passengers, flights and seats by origin–destination pair. Data
cover revenue (paying) passengers on regular public transport (RPT)
services from 2016 onward.

## Usage

``` r
au_dom_routes
```

## Format

Data frame with columns:

- origin_airport:

  Three-letter IATA code of the origin airport (e.g. "SYD" for Sydney).

- dest_airport:

  Three-letter IATA code of the destination airport (e.g. "MEL" for
  Melbourne).

- origin_city:

  Name of the origin city (e.g. `"Sydney"`).

- dest_city:

  Name of the destination city (e.g. `"Melbourne"`).

- year:

  Calendar year, e.g. 2016.

- month:

  Calendar month 1–12 (1 = January, 12 = December).

- n_passengers:

  Number of revenue (paying) passengers carried on the route in that
  month, both directions combined.

- n_flights:

  Number of aircraft trips (flights) operated on the route in that
  month.

- n_seats:

  Total number of seats offered on flights on the route in that month
  (capacity).

## Source

Bureau of Infrastructure and Transport Research Economics (BITRE),
*Domestic aviation statistics – Top routes*. Data downloaded from
<https://www.bitre.gov.au/publications/ongoing/domestic_airline_activity-time_series>.

## Examples

``` r
au_dom_routes
#> # A tibble: 8,595 × 9
#>    origin_airport dest_airport origin_city dest_city  year month n_passengers
#>    <chr>          <chr>        <chr>       <chr>     <dbl> <dbl>        <dbl>
#>  1 ABX            SYD          Albury      Sydney     2016     1        16007
#>  2 ABX            SYD          Albury      Sydney     2016     2        16461
#>  3 ABX            SYD          Albury      Sydney     2016     3        19486
#>  4 ABX            SYD          Albury      Sydney     2016     4        19155
#>  5 ABX            SYD          Albury      Sydney     2016     5        19278
#>  6 ABX            SYD          Albury      Sydney     2016     6        17766
#>  7 ABX            SYD          Albury      Sydney     2016     7        19599
#>  8 ABX            SYD          Albury      Sydney     2016     8        20126
#>  9 ABX            SYD          Albury      Sydney     2016     9        20218
#> 10 ABX            SYD          Albury      Sydney     2016    10        19717
#> # ℹ 8,585 more rows
#> # ℹ 2 more variables: n_flights <dbl>, n_seats <dbl>
```
