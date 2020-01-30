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
      tags$script(src = "shticky-shtuff/shticky.js")
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
#' @details Initialize Shticky
#' 
#' @param id CSS id of element to make shticky.
  public = list(
    initialize = function(id){
      if(missing(id))
        stop("Missing `id`", call. = FALSE)

      # for backward compatibility
      id <- gsub("^#", "", id)
      private$id <- id
      invisible(self)
    },
#' @details Sticks the element.
#' 
#' @param left,right,top,bottom Corresponds to CSS, if an integer it is treated as
#' pixels, if a string is used as-is.
    shtick = function(left = NULL, right = NULL, top = NULL, bottom = NULL){
      session <- private$get_session()

      options <- list()
      if(!is.null(left)) options$left <- .parse_pos(left)
      if(!is.null(right)) options$right <- .parse_pos(right)
      if(!is.null(top)) options$top <- .parse_pos(top)
      if(!is.null(bottom)) options$bottom <- .parse_pos(bottom)

      opts <- list(id = private$id, options = options)
      session$sendCustomMessage("shtick", opts)
      invisible(self)
    },
#' @details Unsticks the element.
    unshtick = function(){
      session <- private$get_session()
      opts <- list(id = private$id)
      session$sendCustomMessage("unshtick", opts) 
      invisible(self)
    }
  ),
  private = list(
    id = NULL,
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

.parse_pos <- function(x){
  if(inherits(x, "numeric"))
    x <- paste0(x, "px")

  return(x)
}