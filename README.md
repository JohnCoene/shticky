# shticky

Make 'Shiny' element *shticky*.

## Installation

``` r
# install.packages("remotes")
remotes::install_github("JohnCoene/shticky")
```

## Example

``` r
library(shiny)
library(shticky)

longdiv <- function(...){
  div(style = "min-height:100vh;", ...)
}

ui <- fluidPage(
  use_shticky(),
  h1(id = "stick", "SHTICKY"),
  longdiv(),
  longdiv(
    verbatimTextOutput("sticky")
  ),
  actionButton("unstick", "UNSHTICK")
)

server <- function(input, output, session) {
  shtick <- Shitck$
    new("#stick")$
    shtick()

  output$sticky <- renderPrint({
    input$shtuck
  })

  observeEvent(input$unstick, {
    shtick$unshtick()
  })
}

shinyApp(ui, server)
```

