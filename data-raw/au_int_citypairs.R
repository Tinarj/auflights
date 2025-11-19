
path <- "data-raw/original/International_airline_activity_OpFltsSeats_0825_Tables.xlsx"
au_int_citypairs <- read_excel(
  path,
  sheet = "Data",
  skip = 11
) |>
  clean_names() |>
  mutate(
    year = year(month),
    month = month(month)
  ) |>
  select(3:13, in_out, year, month) |>
  filter(year >= 2016)


write_csv(au_int_citypairs, "data-raw/au_int_citypairs.csv")
save(au_int_citypairs, file = "data/au_int_citypairs.rda")

