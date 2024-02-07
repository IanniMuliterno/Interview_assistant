box::use(
    shiny[NS,selectInput,moduleServer,reactive,textInput,renderText],
)

#' @export 
ui <- function(id,input_title,placeholder) {
    ns <- NS(id)
    
      textInput(ns("input_text"),
                  input_title,
                  placeholder = placeholder)
}




#' @export 
server <- function(id) {
    moduleServer(
        id = id,
        module = function(session,input,output) {

           input_result <- renderText( {
            input$input_text
           })

           return(input_result)

        }
    )    
    

}