
path <- "data-raw/original/air_fares_1125.xlsx"
au_dom_fares <- read_excel(
  path,
  sheet = "Indexes - CPI Adjusted",
  skip  = 2,
  col_types = c("date", rep("numeric", 8))
) |>
  clean_names() |>
  rename(business_class = real_business_class,
         economy_class   =  real_full_economy
  ) |>
  mutate(year = year(survey_month),
         month = month(survey_month)) |>
  select(business_class, economy_class, month, year) |>
  filter(year >= 2016)


write_csv(au_dom_fares, "data-raw/au_dom_fares.csv")
save(au_dom_fares, file = "data/au_dom_fares.rda")

