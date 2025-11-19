
path <- "data-raw/original/TopRoutesJuly2014September2025.xlsx"
au_dom_routes <- read_excel(
  path,
  sheet = "Top Routes",
  skip  = 13
) |>
  clean_names() |>
  separate(col = city_pair_route_21,
           into = c("origin_city", "dest_city")) |>
  rename(origin_airport = city_pair_route_1,
         dest_airport   =  x2,
         n_passengers = revenue_5,
         n_flights = aircraft_6,
         n_seats = seats_11
  ) |>
  slice(-1, -2) |>
  select(1:2 , origin_city, dest_city, 3:6, n_seats) |>
  filter(year >= 2016) |>
  mutate(
    across(
      c(n_passengers, n_flights, n_seats),
      ~ case_when(
        str_detect(as.character(.x),
                   regex("no flights|covid", ignore_case = TRUE)) ~ 0,

        str_detect(as.character(.x),
                   regex("data not available|not available for release|data not released",
                         ignore_case = TRUE)) ~ NA_real_,

        TRUE ~ readr::parse_number(as.character(.x))
      )
    )
  ) |>
  mutate(
    n_flights = if_else(n_passengers == 0, 0, n_flights),
    n_seats   = if_else(n_passengers == 0, 0, n_seats)
  )

write_csv(au_dom_routes, "data-raw/au_dom_routes.csv")
save(au_dom_routes, file = "data/au_dom_routes.rda")

