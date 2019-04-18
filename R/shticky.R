#' Shticky dependencies
#' 
#' Add sticky dependencies.
#' 
#' @details Put anywhere in your \code{Shiny} ui.
#' 
#' @import shiny
#' @export
use_shticky <- function() {
  singleton(
    tags$head(
      tags$script(src = "shticky-shtuff/jquery.sticky-kit.min.js"),
      tags$script(src = "shticky-shtuff/sticky.js")
    )
  )
}

#' Stick
#'
#' Shticky stuff, euwww
#' 
#' @section Methods:
#' \itemize{
#'   \item{\code{new}: Creates a shticky element, takes a \code{selector}.}  
#'   \item{\code{shtick}: Make the element shticky.}  
#'   \item{\code{unshtick}: Unshticks the element.}  
#' }
#' 
#' @note \code{selector} is a valid CSS selector i.e.: \code{#id} or \code{.class}.
#' 
#' @export
Shtick <- R6::R6Class(
  "Shtick",
  public = list(
    initialize = function(selector){
      private$selector <- selector
      invisible(self)
    },
    shtick = function(inner_scrolling = TRUE, sticky_class = "is_stuck", 
      offset_top = 0, bottoming = TRUE, spacer = NULL){
      session <- private$get_session()
      opts <- list(
        selector = private$selector,
        options = list(
          inner_scrolling = inner_scrolling,
          sticky_class = sticky_class,
          offset_top = offset_top,
          spacer = spacer,
          bottoming = bottoming
        )
      )
      session$sendCustomMessage("shtick", opts)
      invisible(self)
    },
    unshtick = function(){
      session <- private$get_session()
      opts <- list(selector = private$selector)
      session$sendCustomMessage("unshtick", opts) 
      invisible(self)
    }
  ),
  private = list(
    selector = NULL,
    get_session = function(){
      session <- shiny::getDefaultReactiveDomain()
      .check_session(session)
      return(session)
    }
  )
)

.check_session <- function(x){
  if(is.null(x))
    stop("invalid session, run this function inside your Shiny server.", call. = FALSE)
}