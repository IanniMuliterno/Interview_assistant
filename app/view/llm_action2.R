box::use(
  shiny[NS,selectInput,moduleServer,reactive,textOutput,renderText,reactiveVal,eventReactive,observe,invalidateLater,isolate],
  lubridate[seconds_to_period],
)

box::use(
  app/logic/prompt_fun,
  app/logic/API_connection,
)


#' @export 
ui <- function(id) {
  ns <- NS(id)
  
  textOutput(ns("output_text"))
}




#' @export 
server <- function(id, start_button, your_key, position_input, desc_input, company_input, type_input, exp_input) {
  moduleServer(id, function(input, output, session) {

    
    # Use `observeEvent` to listen for the start button and set `active` to TRUE
    result_ai <- eventReactive(start_button(), {
      combinedPrompt <- prompt_fun$prompt_gen(position_input(), desc_input(), company_input(), type_input(), exp_input())
      
      shiny::showNotification(combinedPrompt)
      # Assuming API_connection$your_llm returns a value or text
      API_connection$your_llm(prompt = combinedPrompt, your_bard_key = your_key())
    })
    
    
    output$output_text <- renderText({
     
      result_ai()
      
    })
  })
}
