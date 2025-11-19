
path <- "data-raw/original/International_airline_activity_CityPairs_2009toCurrent_0825.xlsx"
au_int_routes <- read_excel(
  path,
  sheet = "Data"
) |>
  clean_names() |>
  rename(origin_city = australian_port,
         dest_city = foreign_port,
         dest_country = country,
         n_passengers_in = pax_in,
         n_passengers_out = pax_out
  ) |>
  select(2:5, n_passengers_out, year, month) |>
  mutate(
    month = month(month),
    across(
      c(n_passengers_in, n_passengers_out),
      ~ case_when(
        .x == ".."          ~ NA_real_,
        TRUE                ~ parse_number(as.character(.x))
      )
    )
  ) |>
  filter(year >= 2016)


write_csv(au_int_routes, "data-raw/au_int_routes.csv")
save(au_int_routes, file = "data/au_int_routes.rda")

