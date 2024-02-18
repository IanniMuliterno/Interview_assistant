box::use(
  shiny[NS, selectInput, moduleServer, reactive, textInput, renderText, req],
)

#' @export
ui <- function(id, input_title, placeholder) {
  ns <- NS(id)

  textInput(ns("input_text"),
    label = input_title,
    placeholder = placeholder
  )
}



#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    text_value <- reactive({
      input$input_text
    })

    return(list(value = textValue))
  })
}