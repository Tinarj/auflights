library(shiny)
library(bslib)
library(dplyr)
library(ggplot2)
library(cassowaryr)

#-------------------------------------------------------------------
load("data/au_dom_routes.rda")
#-------------------------------------------------------------------

df_num <- au_dom_routes |> dplyr::select(where(is.numeric))

scag_funs <- list(
  "Stringy (sc_stringy)"     = cassowaryr::sc_stringy,
  "Outlying (sc_outlying)"   = cassowaryr::sc_outlying,
  "Skewed (sc_skewed)"       = cassowaryr::sc_skewed,
  "Skinny (sc_skinny)"       = cassowaryr::sc_skinny,
  "Clumpy (sc_clumpy)"       = cassowaryr::sc_clumpy,
  "Striated (sc_striated)"   = cassowaryr::sc_striated,
  "Convex (sc_convex)"       = cassowaryr::sc_convex,
  "Monotonic (sc_monotonic)" = cassowaryr::sc_monotonic,
  "Sparse (sc_sparse)"       = cassowaryr::sc_sparse
)

#-------------------------------------------------------------------
# UI
#-------------------------------------------------------------------
ui <- page_sidebar(
  title = "Australian routes: scagnostics explorer",

  theme = bs_theme(
    version  = 5,
    primary  = "#0072B2",
    secondary = "#F39C12",
    bg = "#f8f9fa",
    fg = "#222222",
    base_font = font_google("Roboto")
  ),

  sidebar = sidebar(
    tags$head(
      tags$style(HTML("
        .section-card {
          border-radius: 0.75rem;
          margin-bottom: 1rem;
          padding: 0.75rem 0.75rem 0.25rem 0.75rem;
          border: 1px solid #dee2e6;
          background-color: #ffffff;
        }
        .section-title {
          font-weight: 600;
          margin-bottom: 0.5rem;
          padding-bottom: 0.25rem;
          border-bottom: 2px solid #0072B2;
          color: #0072B2;
        }
      "))
    ),

    # --- Variables section ---------------------------------------------------
    div(class = "section-card",
        div(class = "section-title", "Variables"),
        varSelectInput(
          "xvar", "X variable", df_num,
          selected = "n_flights"
        ),
        varSelectInput(
          "yvar", "Y variable", df_num,
          selected = "n_passengers"
        )
    ),

    # --- Filters section -----------------------------------------------------
    div(class = "section-card",
        div(class = "section-title", "Filters"),
        sliderInput(
          "year_range", "Year range",
          min   = min(au_dom_routes$year, na.rm = TRUE),
          max   = max(au_dom_routes$year, na.rm = TRUE),
          value = c(min(au_dom_routes$year, na.rm = TRUE),
                    max(au_dom_routes$year, na.rm = TRUE)),
          sep = ""
        ),
        selectInput(
          "month_filter", "Month (optional)",
          choices = c("All" = "", setNames(1:12, month.abb)),
          selected = ""
        ),
        selectInput(
          "origin_filter", "Origin airport (optional)",
          choices = c("All" = "", sort(unique(au_dom_routes$origin_airport))),
          selected = ""
        ),
        selectInput(
          "dest_filter", "Destination airport (optional)",
          choices = c("All" = "", sort(unique(au_dom_routes$dest_airport))),
          selected = ""
        ),
        selectInput(
          "colour_by", "Colour points by",
          choices = c("None", "Year", "Month"),
          selected = "Year"
        )
    ),

    # --- Scagnostics section -------------------------------------------------
    div(class = "section-card",
        div(class = "section-title", "Scagnostics"),
        checkboxGroupInput(
          "which_scag", "Measures to compute",
          choices  = names(scag_funs),
          selected = names(scag_funs)[1]   # only Stringy by default
        ),
        helpText("Scagnostics are based on the chosen X and Y variables.")
    )
  ),

  # Main content: put plot & table each in a card with borders
  layout_columns(
    col_widths = c(8, 4),

    # Plot card ---------------------------------------------------------------
    card(
      full_screen = TRUE,
      card_header("Route scagnostics scatterplot"),
      plotOutput("scatter", height = 500)
    ),

    # Table card --------------------------------------------------------------
    card(
      card_header("Scagnostic values"),
      tableOutput("scag_table")
    )
  )
)

#-------------------------------------------------------------------
# Server
#-------------------------------------------------------------------
server <- function(input, output, session) {

  filtered_data <- reactive({
    d <- au_dom_routes

    d <- d |>
      filter(
        year >= input$year_range[1],
        year <= input$year_range[2]
      )

    if (nzchar(input$month_filter)) {
      d <- d |> filter(month == as.integer(input$month_filter))
    }
    if (nzchar(input$origin_filter)) {
      d <- d |> filter(origin_airport == input$origin_filter)
    }
    if (nzchar(input$dest_filter)) {
      d <- d |> filter(dest_airport == input$dest_filter)
    }
    d
  })

  xy_data <- reactive({
    req(input$xvar, input$yvar)

    d <- filtered_data()
    x <- d[[as.character(input$xvar)]]
    y <- d[[as.character(input$yvar)]]

    ok <- is.finite(x) & is.finite(y)
    x <- x[ok]; y <- y[ok]; d <- d[ok, , drop = FALSE]

    validate(
      need(length(x) >= 3,
           "Not enough valid numeric points to calculate scagnostics.")
    )

    list(x = x, y = y, df = d)
  })

  output$scatter <- renderPlot({
    xy <- xy_data()
    d  <- xy$df

    colour_aes <- switch(
      input$colour_by,
      "Year"  = aes(colour = factor(year)),
      "Month" = aes(colour = factor(month)),
      "None"  = NULL
    )

    ggplot(d, aes(x = !!input$xvar, y = !!input$yvar)) +
      colour_aes +
      geom_point(alpha = 0.7, size = 2)  +
      scale_x_continuous(labels = scales::label_comma()) +
      scale_y_continuous(labels = scales::label_comma()) +
      theme_minimal(base_size = 14) +
      theme(
        panel.border = element_rect(colour = "grey60", fill = NA, linewidth = 0.8),
        plot.title.position = "plot"
      ) +
      labs(
        x = as_label(input$xvar),
        y = as_label(input$yvar),
        colour = ifelse(input$colour_by == "None", "", input$colour_by),
        title = NULL,
        subtitle = paste0(
          "Years: ", input$year_range[1], "–", input$year_range[2],
          ifelse(
            nzchar(input$month_filter),
            paste0(" | Month: ", month.abb[as.integer(input$month_filter)]),
            " | Month: All"
          ),
          " | Origin: ",
          ifelse(nzchar(input$origin_filter), input$origin_filter, "All"),
          " | Destination: ",
          ifelse(nzchar(input$dest_filter), input$dest_filter, "All")
        )
      )
  })

  output$scag_table <- renderTable({
    xy <- xy_data()
    x  <- xy$x
    y  <- xy$y

    chosen <- input$which_scag
    req(chosen)

    vals <- purrr::map_dbl(chosen, function(label) {
      f <- scag_funs[[label]]
      f(x, y)
    })

    tibble::tibble(
      measure = chosen,
      value   = round(vals, 3)
    )
  })
}

shinyApp(ui, server)



