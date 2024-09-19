# app launching code, e.g.:
# shiny::runApp(appDir = "./inst/app/", launch.browser=TRUE)
#' Launch Shiny App to convert Longitude and Latitude degrees to decimal degrees
#'
#' @export
launch_app <- function() {
  appDir <- system.file("app", package = "CoordFixR")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing 'CoordFixR'.", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = "normal")
}
