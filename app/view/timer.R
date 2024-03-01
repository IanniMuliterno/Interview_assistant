box::use(
  shiny[NS, req, selectInput, moduleServer, reactive, textOutput, renderText,
        reactiveVal, observeEvent, observe, invalidateLater, showModal, modalDialog,isolate],
  lubridate[seconds_to_period],
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  textOutput(ns("output_text"))
}




#' @export
server <- function(id, timespan, start_button, next_button, finish_button) {
  moduleServer(id, function(input, output, session) {
    timer <- reactiveVal()
    active <- reactiveVal(FALSE)
    
    
    
    output$output_text <- renderText({
      paste("Time left: ", seconds_to_period(timer()))
    })


    observe( {
      invalidateLater(1000, session)
      
      isolate({
        
        if (active()) {
          
          if(timer() > 0) {
            
            timer(timer() - 1) 
            
          } else {
            active(FALSE)
            showModal(modalDialog(
              title = "Important message",
              "Countdown completed!"
            ))
          }
        }
        
      })
      
    })

    observeEvent(start_button(), {
      timer(timespan())
      active(TRUE)
    })
    
    
    observeEvent(finish_button(), {
      active(FALSE) # Stop the timer
    })
    
    observeEvent(next_button(), {
      timer(timespan())
      active(TRUE)
    })
    
  })
}
