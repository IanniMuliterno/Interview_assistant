box::use(
  shiny[NS,selectInput,moduleServer,reactive,textOutput,renderText,reactiveVal,eventReactive,observe,invalidateLater],
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

    
  
    result_ai <- eventReactive(start_button(), {

      #combinedPrompt <- prompt_fun$prompt_gen(position_input, desc_input, company_input, type_input, exp_input)
      combinedPrompt <- prompt_fun$prompt_gen(position_input$value(), desc_input$value(), company_input$value(),
                            type_input$value(), exp_input$value())

      shiny::showNotification(combinedPrompt)

      #API_connection$your_llm(prompt = combinedPrompt, your_bard_key = your_key())
    })


    # output$output_text <- renderText({
    # 
    #   result_ai()
    # 
    # })
  })
}

