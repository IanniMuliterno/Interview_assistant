box::use(
    shiny[NS,selectInput,moduleServer,reactive],
    graphics,
)

#' @export 
ui <- function(id,input_title,choice_list) {
    ns <- NS(id)
    
      selectInput(ns("input_text"),
                  input_title,
                  multiple = F,
                  selectize = T,
                  choices = choice_list)
}




#' @export 
server <- function(id) {
    moduleServer(
        id = id,
        module = function(session,input,output) {

           input_result <- reactive( {
            input$input_text
           })

           return(input_result)

        }
    )    
    

}