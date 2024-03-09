box::use(
  shiny[
    NS, HTML, selectInput, moduleServer, reactive, uiOutput, renderUI,
    reactiveVal, eventReactive, observeEvent, observe, invalidateLater, req
  ],
  lubridate[seconds_to_period],
  stringr[str_split],
  markdown[markdownToHTML]
)

box::use(
  app/logic/prompt_fun,
  app/logic/api_connection,
)


#' @export
ui <- function(id) {
  ns <- NS(id)

  uiOutput(ns("output_text"))
}




#' @export
server <- function(id, start_button, next_button, your_key, position_input, desc_input,
                   company_input, type_input, exp_input) {
  moduleServer(id, function(input, output, session) {
    current_question_index <- reactiveVal(1)

    questions <- eventReactive(start_button(), {
      combined_prompt <- prompt_fun$prompt_gen(
        position_input$value(), desc_input$value(), company_input$value(),
        type_input$value(), exp_input$value()
      )

      api_output <- api_connection$your_llm(
        prompt = combined_prompt,
        your_bard_key = your_key$value()
      )

      result <- str_split(api_output, "[0-9]\\.|\\*\\*X Awesome Advice X\\*\\*")
      
      return(result[[1]])
    })

    observeEvent(next_button(), {
      if (current_question_index() < (length(questions()) - 1)) {
        current_question_index(current_question_index() + 1)
      } else {
        current_question_index(1)
      }
    })


    output$output_text <- renderUI({
      req(questions())
      question_list <- questions()
      if (is.null(question_list) || length(question_list) == 0) {
        return()
      } else {
        fixed_title <- paste(
          question_list[1],
          "\n\n",
          "you have", length(question_list) - 2, "questions \n\n"
        )


        final_result <- paste(fixed_title, question_list[current_question_index() + 1])


        HTML(markdownToHTML(text = final_result, fragment.only = TRUE))

      }
    })
    
    return(questions)
    
  })
}
