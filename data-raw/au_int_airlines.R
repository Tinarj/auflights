
path <- "data-raw/original/International_airline_activity_Flights_seats_0825.xlsx"
au_int_airlines <- read_excel(
  path,
  sheet = "Data",
  skip = 4
) |>
  clean_names() |>
  rename(n_flights_in = flts_in,
         n_passengers_in = pax_in,
         n_seats_in = seats_in,
         n_flights_out = flts_out,
         n_passengers_out = pax_out,
         n_seats_out = seats_out,
         year = cal_y
  ) |>
  select(2:8, year, month) |>
  mutate(
    month = month(month),
    across(
      c(n_flights_in:n_passengers_out),
      ~ case_when(
        .x == ".."          ~ NA_real_,
        TRUE                ~ parse_number(as.character(.x))
      )
    )
  ) |>
  filter(year >= 2016)


write_csv(au_int_airlines, "data-raw/au_int_airlines.csv")
save(au_int_airlines, file = "data/au_int_airlines.rda")

