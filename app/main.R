box::use(
  shiny,
)

box::use(
  app/view/itvw_type
)

#' @export
ui <- function(id) {
  ns <- shiny$NS(id)
  shiny$bootstrapPage(
    itvw_type$ui(id = ns("itvw_type"),
    input_title = "Who is interviewing you",
    choice_list = c("HR","Tech manager")

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
