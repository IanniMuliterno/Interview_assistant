box::use(
  shiny[NS,selectInput,moduleServer,reactive,textOutput,renderText,reactiveVal,observeEvent,observe,invalidateLater,isolate],
  lubridate[seconds_to_period],
)

#' @export 
ui <- function(id) {
  ns <- NS(id)
  
  textOutput(ns("output_text"))
}




#' @export 
server <- function(id,timespan,start_button,next_button,finish_button) {
  moduleServer(
    id = id,
    module = function(input,output,session) {
      
      
      timer <- reactiveVal(180)
      active <- reactiveVal(FALSE)
      
      output$output_text <- renderText({
  
        paste("Time left: ", seconds_to_period(timer()))
      })
      
      observe({
        invalidateLater(1000, session)
        isolate({
          if(active())
          {
            timer(timer()-1)
            if(timer()<1)
            {
              active(FALSE)
              showModal(modalDialog(
                title = "Important message",
                "Countdown completed!"
              ))
            }
          }
        })
      })
      
      
      observeEvent(start_button(), {active(TRUE)})
      
      observeEvent(finish_button(), {active(FALSE)})
      
      observeEvent(next_button(), {
        timer(timespan)
        active(TRUE)
        })
      
      
      
      
    }
  )    
  
  
}