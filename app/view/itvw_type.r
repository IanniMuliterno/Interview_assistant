box::use(
  shiny[NS, selectInput, moduleServer, reactive],
)

#' @export
ui <- function(id, input_title, choice_list) {
  ns <- NS(id)

  selectInput(ns("input_text"),
    input_title,
    multiple = FALSE,
    selectize = TRUE,
    choices = choice_list
  )
}


server <- function(id) {
  moduleServer(id,
    module = function(input, output, session) {
      text_value <- reactive({
        input$input_text
      })

      return(list(value = text_value))
    }
  )
}