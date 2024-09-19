# UI.R
# inst/app/UI.R

library(dplyr)
library(DT)
library(leaflet)
library(readxl)
library(shiny)
library(writexl)


fluidPage(

  div(
    style = "text-align: center;",
    HTML("<h1>CoordFixR</h1><h3>calculates/converts coordinates from (almost) all possible notations to decimal degrees")
  ),
  div(
    style = "position: absolute; top: 10px; right: 10px;",
    tags$img(src = "COORDFIXR.jpg", width=150, height=150)
  ),

  # titlePanel("CoordConverter - calculates/converts coordinates of all possible notations to decimal degrees"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose Excel File", accept = c(".xlsx")),
      br(),

      uiOutput("first_coord"),
      uiOutput("second_coord"),

      # selectInput("x_var", "Select Longitude (east and west of Greenwich, a.k.a. 'Long', 'Lon', 'X')", choices = NULL),
      # selectInput("y_var", "Select Latitude (north and south of the Equator, a.k.a. 'Lat', 'Y')", choices = NULL),
      # selectInput("column_select2", "Select Longitude (east and west of Greenwich, a.k.a. 'Long', 'Lon', X)", choices = NULL),
      br(),
      actionButton("calculateBtn", "Calculate"),
      br(),
      br(),

      uiOutput("long_select"),
      uiOutput("lat_select"),
      uiOutput("plot_map"),

      # actionButton("drop_rows", "Drop incomplete rows"),
      # actionButton("plotMapBtn", "Plot as map"),
      # br(),
      # hr(),
      # actionButton("editButton", "Edit Data"),
      br(),
      hr(),
      downloadButton("downloadBtn", "Download Excel File"),
      br(),
      hr(),
      br(),
      actionButton("resetBtn", "Reset")
    ),
    mainPanel(
      tabsetPanel(
        id = "tabs",
        tabPanel("Data Frame",
                 DTOutput("contents"),  # Display the data table
                 # tableOutput("contents")
        ),
        tabPanel("Map",
                 leafletOutput("map",height = "700px"),
                 tableOutput("table")
        )

      )
    )
  )
)  # *** END OF 'fluidPage(' ***
