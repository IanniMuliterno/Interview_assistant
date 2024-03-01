box::use(
  shiny[NS, req, selectInput, moduleServer, reactive, textOutput, renderText,
        reactiveVal, observeEvent, observe, invalidateLater, showModal, modalDialog,isolate],
  lubridate[seconds_to_period],
  dplyr[bind_rows],
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  textOutput(ns("output_text"))
}




#' @export
server <- function(id, timespan, start_button, next_button, finish_button) {
  moduleServer(id, function(input, output, session) {
  
    hist_df <- reactiveVal(data.frame(time_spent = numeric()))
    
    timer <- reactiveVal()
    timer2 <- reactiveVal(0)
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

          }
          
          timer2(timer2() + 1)
        }
        
      })
      
    })

    observeEvent(start_button(), {
      timer(timespan())
      timer2(0)
      active(TRUE)
    })
    
    
    observeEvent(finish_button(), {
      active(FALSE) 
    })
    
    observeEvent(next_button(), {
      timer(timespan())
      active(TRUE)
      
      current_df <- hist_df()
      hist_df(
        bind_rows(
          current_df,data.frame(
            time_spent = timer2()
          )
        )
      )
      
      timer2(0)
    })
    
    return(hist_df)
    
  })
}
