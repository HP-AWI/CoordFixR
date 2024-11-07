# Server.R
#inst/app/Server.R

function(input, output, session) {

  filtered_data <- reactiveVal(df)
  output$filtered_table <- renderTable({
    filtered_data()
  })

  ############################################################################
  #_____________________________________________________________________________

  # Function to clean and replace values
  clean_and_replace <- function(x) {
    if (!grepl("\\d", x, perl = TRUE)) {
      return(NA)
    } else {
      return(x)
    }
  }

  #_____________________________________________________________________________
  ###  create long and lat transformation function
  # tmp is the column that consists the values to transform: tmp <- data$Long
  # selected_column is the name of the selected column
  # head(tmp)
  # i <- 1
  ################################################################################
  FUNC_transform_degrees <- function(tmp, selected_column) {
  tmp_result <- numeric(length(tmp))
  # pon <- NULL
  # pon <- ifelse(grepl("W|S", tmp), -1, 1)

  i <- 10
  for (i in seq_along(tmp)) {
    if (exists("result1")) { result1 <- NA}

    ##########################################################################
    if (!grepl("\\d", tmp[i], perl = TRUE)) {
      tmp4 <- 'NA'
    } else {
      ##########################################################################
      pon <- 1
      # Names or values for 'negative' hemispheres
      value1 <- c("-",
                  "W",
                  "w",
                  "S",
                  "O",
                  "o",
                  "West",
                  "Süd",
                  "South",
                  "Oeste",
                  "Sur",
                  "Ouest",
                  "Sud")

      # check if values of 'value1' is present in the actiual cell value (tmp[i])
      p_n_test <- stringr::str_detect(tmp[i], value1)

      # if so add a minus ("-") to the converted result value (DD, decimal degrees)
      if (any(p_n_test)) {
        pon <- -1
      }

      # if not remove 'pn_test'
      rm(p_n_test)
      #_____________________________________________________________________________
      # Check if ',' is used as a decimal separator and replace with '.'
      if (grepl(',', tmp[i])) {
        # Replace ',' with '.'
        # result1 <- gsub(',', '.', tmp[i])  # old version
        result1 <- gsub(r"{(\d)\,(\d)}", r"{\1.\2}", tmp[i])  # new version
      } else {
        result1 <- tmp[i]
      }

      #_____________________________________________________________________________

      # gsub('(/|S|N|W|E|°|\'|\'')',
      # Replace all characters that are not numbers with '_'
      if (exists("results")) { rm(results) }
      results <- gsub('[^0-9.]', '_', result1)
      rm(result1)

      # Replace consecutive occurrences of '_' with a single '_'
      results <- gsub('_+', '_', results)

      # Remove '_' at the end of each string
      results <- sub('_+$', '', results)

      # Remove '_' at the beginning of each string
      results <- sub('^_+', '', results)

      tmp3 <- t(as.data.frame(strsplit(results, "_", fixed=FALSE)))
      rm(results)

      # if there are mor than three entries in tmp3 do this
      if (length(tmp3) > 3) {
        if (exists("drop_me")) { rm(drop_me) }
        drop_me <- !is.na(as.numeric(tmp3))
        tmp3 <- tmp3[which(drop_me==TRUE)]
        rm(drop_me)
      }


      if (length(tmp3) == 1) {
        tmp4 <- 'NA'

        # multiply with 'pon' to add "-" if coordinates in western or southern hemisphere
        tmp4 <- pon * abs(as.numeric(tmp3[1]))

        # else if the length of 'tmp3' is greater as 1
      } else if (length(tmp3) == 2) {
        d <- abs(as.numeric(tmp3[1]))
        m <- as.numeric(tmp3[2]) / 60
        s <- 0
        tmp4 <- pon * (d + m + s)
        rm(d, m, s)
      } else if (length(tmp3) == 3) {
        tmp4 <- 'NA'
        d <- abs(as.numeric(tmp3[1]))
        m <- as.numeric(tmp3[2]) / 60
        s <- as.numeric(tmp3[3]) / 3600
        tmp4 <- pon * (d + m + s)
        rm(d, m, s)
      }

      ##########################################################################
    }

    # add converted coordinates (decimal degrees) to th position 'i' of the result list
    tmp_result[i] <- NA

    if (!is.na(tmp4)){
      tmp_result[i] <- as.numeric(tmp4)
    }

    if (is.na(tmp4)){
      tmp_result[i] <- NA
    }
    # i <- i+1
  }

  return(tmp_result)
}   # *** End of 'FUNC_transform_degrees <-' ***
  ################################################################################

  # Read the selected Excel file
  data <- reactiveVal(NULL)
  counter <- reactiveVal(0)
  selected_columns <- reactiveVal(character(0))

  observeEvent(input$file1, {
    req(input$file1)
    inFile <- input$file1
    if (is.null(inFile)) return(NULL)
    df <- read_excel(inFile$datapath)


    # Update the selection list in the selectInput widgets
    updateSelectInput(session, "x_var", choices = colnames(df))
    updateSelectInput(session, "y_var", choices = colnames(df))

    output$first_coord <- renderUI({
      selectInput("x_var", "Select Longitude (east and west of Greenwich, a.k.a. 'Long', 'Lon', 'X')", choices = NULL)
    })

    output$second_coord <- renderUI({
      selectInput("y_var", "Select Latitude (north and south of the Equator, a.k.a. 'Lat', 'Y')", choices = NULL)
    })

    data(df)
    updateTabsetPanel(session, "tabs", selected = "Data Frame")
  })

  # Display the contents of the Excel file
  output$contents <- renderDT({ datatable(
    data(),
    options = list(
      scrollX = TRUE,  # Enable horizontal scrolling
      scrollY = '700px',# Set a specific height for vertical scrolling
      pageLength = 15, info = FALSE,
      lengthMenu = list(c(15, -1), c("15", "All"))
    )
  ) })
  # output$contents <- renderTable({ data() })

  # Calculate selected column
  observeEvent(input$calculateBtn, {
    req(input$file1)
    req(input$x_var)
    req(input$y_var)

    updateTabsetPanel(session, "tabs", selected = "Data Frame")

    inFile <- input$file1
    if (is.null(inFile)) return(NULL)

    df <- data()
    col_selected <<- input$y_var
    col_selected2 <<- input$x_var

    new_col <- paste0(col_selected, "_new")
    new_col2 <- paste0(col_selected2, "_new")

    ##########################################################################
    # df[[new_col]] <- df[[col_selected]] * 2
    df[[new_col]] <- FUNC_transform_degrees(df[[col_selected]],
                                            col_selected)
    df[[new_col2]] <- FUNC_transform_degrees(df[[col_selected2]],
                                             col_selected2)
    ##########################################################################

    data(df)
    counter(counter() + 1)
    selected_columns(c(selected_columns(), col_selected))


    observe({
      x_col_new <- paste0(input$x_var, "_new")
      y_col_new <- paste0(input$y_var, "_new")

      output$long_select <- renderUI({
        selectInput("x_new_var", "Select new LONGITUDE values:", choices = colnames(data()), selected = x_col_new)
      })

      output$lat_select <- renderUI({
        selectInput("y_new_var", "Select new LATITUDE values:", choices = colnames(data()), selected = y_col_new)
      })

      output$plot_map <- renderUI({
        actionButton("plotMapBtn", "Plot as map")
      })
    })

  })  # *** END OF 'observeEvent(input$calculateBtn, ' ***

  # Download the data as an Excel file
  output$downloadBtn <- downloadHandler(
    filename = function() {
      paste("output", ".xlsx", sep = "")
    },
    content = function(file) {
      if (!is.null(data())) {
        write_xlsx(data(), file)
      }
    }
  )
  ############################################################################
  observeEvent(input$drop_rows, {
    req(input$x_new_var, input$y_new_var)
    column1 <- input$y_var
    column2 <- input$x_var
    if (column1 != "" && column2 != "") {
      filtered_data(df %>% filter(
        (!is.na(.df[[column1]]) & .df[[column1]] != "" & !is.na(.df[[column2]]) & .df[[column2]] != "")
      ))
    }
  })
  ############################################################################
  # Create leaflet map
  observeEvent(input$plotMapBtn, {
    output$map <- renderLeaflet({
      req(input$x_new_var, input$y_new_var)

      long_col <- input$x_new_var
      lat_col <- input$y_new_var

      df <- data()

      # Convert selected latitude and longitude columns to numeric
      df[[lat_col]] <- as.numeric(df[[lat_col]])
      df[[long_col]] <- as.numeric(df[[long_col]])

      if ("Places" %in% colnames(df)) {
        leaflet(df) %>%
          addTiles() %>%
          addMarkers(lng = ~df[[long_col]], lat = ~df[[lat_col]], label = ~Places)
      } else {
        leaflet(df) %>%
          addTiles() %>%

          #__________________________________
          # use addAwesomeMarkers #
          addAwesomeMarkers(
            lat = ~df[[lat_col]],
            lng = ~df[[long_col]],
            icon=~makeAwesomeIcon(
              icon = 'ios-close',
              iconColor = 'black',
              library = 'ion',
              markerColor = 'orange'),

            label = ~rownames(df),

            popup = ~paste("Row number: ", rownames(df),
                           "<br>Longitude: ", df[[long_col]],
                           "<br>Latitude: ", df[[lat_col]]),

            clusterOptions = markerClusterOptions()
          ) %>%
          #__________________________________
          addTiles(group = "OSM (default)") %>%  # Default OpenStreetMap layer
          addProviderTiles(providers$OpenTopoMap, group = "OpenTopoMap") %>%
          addProviderTiles(providers$Esri.WorldImagery, group = "Esri WorldImagery") %>%
          addProviderTiles(providers$Esri.WorldPhysical, group = "Esri World Physical")  %>%
          # addProviderTiles(providers$Esri.Ocean_Base_map, group = "Esri Ocean basemaps") %>%
          # addWMSTiles(
          #   "https://maps.ngdc.noaa.gov/arcgis/services/gebco08_hillshade/MapServer/WMSServer",
          #   layers = "0",
          #   options = WMSTileOptions(format = "image/png", transparent = TRUE),
          #   attribution = "NOAA"
          # ) %>%

          # Add layer control to switch between basemaps
          addLayersControl(baseGroups = c("OSM (default)",
                                          "OpenTopoMap",
                                          "Esri WorldImagery",
                                          "Esri World Physical"#,
                                          #"Esri Ocean basemaps"
                                          ),
                           options = layersControlOptions(collapsed = FALSE)
                           ) %>%
          #__________________________________

          addSimpleGraticule(
            showOriginLabel = TRUE,
            redraw = "move",
            hidden = FALSE,
            zoomIntervals = list(
              list(start = 1, end = 2, interval = 30),
              list(start = 3, end = 3, interval = 20),
              list(start = 3, end = 4, interval = 10),
              list(start = 5, end = 5, interval = 5),
              list(start = 6, end = 6, interval = 2.5),
              list(start = 7, end = 7, interval = 1),
              list(start = 8, end = 9, interval = 0.5),
              list(start = 9, end = 9, interval = 0.1),
              # list(start = 10, end = 20, interval = 0.05),
              list(start = 11, end = 25, interval = 0.05) #,
              # list(start = 12, end = 22, interval = 0.0125) #,
              # list(start = 14, end = 13, interval = 0.001),
              # list(start = 14, end = 22, interval = 0.005)
            ))
      }
    })

    #####

    #####

    # updateTabsetPanel(session, "main_panel", selected = "Map")
    updateTabsetPanel(session, "tabs", selected = "Map")
  })

  observeEvent(input$resetBtn, {
    data(NULL)
    # Update the selection list in the selectInput widgets
    updateSelectInput(session, "y_var", selected = NULL)
    updateSelectInput(session, "x_var", selected = NULL)

    updateTabsetPanel(session, "tabs", selected = "Data Frame")
  })

}
