box::use(
  shiny[NS, req, selectInput, moduleServer, reactive, textOutput, renderText,
        reactiveVal, observeEvent, observe, invalidateLater, showModal, modalDialog],
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
    timer <- reactiveVal(180)
    active <- reactiveVal(FALSE)

    observeEvent(start_button(), {
      timer(timespan()) # Initialize with timespan at start
      active(TRUE)
    })


    observeEvent(finish_button(), {
      active(FALSE) # Stop the timer
    })


    observe({
      if (active()) {
        invalidateLater(1000, session)
        timer(timer() - 1) # Decrement timer
        if (timer() <= 0) {
          active(FALSE)
          showModal(modalDialog(
            title = "Important message",
            "Countdown completed!"
          ))
        }
      }
    })

    output$output_text <- renderText({
      paste("Time left: ", seconds_to_period(timer()))
    })
  })
}
