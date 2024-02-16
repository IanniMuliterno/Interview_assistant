box::use(
  shiny[NS,HTML,selectInput,moduleServer,reactive,uiOutput,renderUI,reactiveVal,eventReactive,observeEvent,observe,invalidateLater],
  lubridate[seconds_to_period],
  stringr[str_split],
  markdown[markdownToHTML]
)

box::use(
  app/logic/prompt_fun,
  app/logic/API_connection,
)


#' @export 
ui <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("output_text"))
}




#' @export 
server <- function(id, start_button,next_button, your_key, position_input, desc_input, company_input, type_input, exp_input) {
  moduleServer(id, function(input, output, session) {

    currentQuestionIndex <- reactiveVal(1)
  
    questions <- eventReactive(start_button(), {

      combinedPrompt <- prompt_fun$prompt_gen(position_input$value(), desc_input$value(), company_input$value(),
                            type_input$value(), exp_input$value())

      #shiny::showNotification(combinedPrompt)
      
      API_output <- API_connection$your_llm(prompt = combinedPrompt, your_bard_key = your_key$value())
      
      result <- str_split(API_output,"[0-9]\\.|\\*\\*X Awesome Advice X\\*\\*")
      
      result[[1]]
      
    })
    
    observeEvent(next_button(), {
      
      if(currentQuestionIndex() < (length(questions()) - 1)) {
        
        currentQuestionIndex(currentQuestionIndex() + 1)
        
      } else {
        
        currentQuestionIndex(1)
        
      }
      
    })


    output$output_text <- renderUI({
      
      questionList <- questions()
      if (is.null(questionList) || length(questionList) == 0) {
        
        return()
        
      } else {
        
        
        fixed_title <- paste(questionList[1],
                             "\n\n",
                             "you have",length(questionList) - 2, "questions \n\n")
        
        
        final_result <- paste(fixed_title, questionList[currentQuestionIndex() + 1])
        
        
        HTML(markdownToHTML(text = final_result, fragment.only = TRUE))
        
        
        
        
      }
      
      

    })
  })
}

