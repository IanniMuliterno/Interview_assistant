box::use(
  shiny,
  bslib,
)

box::use(
  app/view/itvw_type,
  app/view/text_input,
)

#' @export
ui <- function(id) {
  ns <- shiny$NS(id)
  shiny$fluidPage(
    theme = bslib$bs_theme(bootswatch = "darkly"),
    
    shiny$fluidRow(
      itvw_type$ui(
        id = ns("itvw_type"),
        input_title = "Who is interviewing you",
        choice_list = c("HR","Tech manager")
        ),
      text_input$ui(
        id = ns("position"),
        "Position",
        "insert position here"
      )  

    

    ),
    shiny$uiOutput(ns("message"))
  )
}

#' @export
server <- function(id) {
  shiny$moduleServer(id, function(input, output, session) {
    output$message <- shiny$renderUI({
      
      "hello world"
      
    })
  })
}
