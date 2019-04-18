.onLoad <- function(libname, pkgname) {
  shiny::addResourcePath(
    "shticky-shtuff",
    system.file("sticky-kit", package = "shticky")
  )
}