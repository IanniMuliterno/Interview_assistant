box::use(
  shiny,
  bslib,
  shinyjs,
)

box::use(
  app/view/itvw_type,
  app/view/text_input,
  app/logic/api_connection,
  app/view/timer,
  app/view/llm_action2,
  app/view/histogram,
  app/view/download,
)

#' @export
ui <- function(id) {
  ns <- shiny$NS(id)

  shiny$fluidPage(
    shinyjs$useShinyjs(),
    theme = bslib$bs_theme(preset = "morph"),
    shiny$sidebarLayout(
      shiny$sidebarPanel(
        text_input$ui(
          id = ns("key"),
          "Bard key",
          "insert your bard key"
        ),
        shiny$numericInput(ns("settime"), "Seconds:", value = 180, min = 0, max = 240, step = 1),
        bslib$card(
          full_screen = FALSE,
          bslib$card_header("Directions"),
          shiny$HTML("Maximize your interview impact. Everything you need is to generate a bard key
                     and 'interviewpro' will guide you to concise and compelling self-presentation.
                   <p>Find your own Bard API by following the instructions here: <a
                   href='https://www.cloudbooklet.com/ai-text/googles-bard-api-key/'
                   target='_blank'>
                   https://www.cloudbooklet.com/ai-text/googles-bard-api-key/</a></p>")
        ),
        bslib$card(
          bslib$card_header("Timer"),
          timer$ui(ns("timerid"))
        ),
        bslib$card(
          download$ui(ns("download"), "Download content"),
          download$ui(ns("download_times"), "Download time table")
        )
      ),
      shiny$mainPanel(
        bslib$layout_columns(
          itvw_type$ui(
            id = ns("itvw_type"),
            input_title = "Interviewer",
            choice_list = c("HR", "Tech manager")
          ),
          text_input$ui(
            id = ns("position"),
            "Position",
            "insert position here"
          ),
          text_input$ui(
            id = ns("job_desc"),
            "Job description",
            "under 300 words"
          ),
          text_input$ui(
            id = ns("company"),
            "Company",
            "Target company?"
          ),
          text_input$ui(
            id = ns("experience"),
            "Your experience",
            "under 300 words"
          )
        ),
        bslib$layout_columns(
          shiny$actionButton(ns("start"), "Tailor my questions"),
          shiny$actionButton(ns("nextq"), "Ask next question"),
          shiny$actionButton(ns("finish"), "Finish")
        ),
        bslib$layout_columns(
          bslib$card(
            full_screen = TRUE,
            bslib$card_header("Your customized questions"),
            llm_action2$ui(ns("out_ai"))
          )
        ),
        bslib$layout_columns(
          histogram$ui(ns("hist"))
        )
      )
    )
  )
}

#' @export
server <- function(id) {
  shiny$moduleServer(id, function(input, output, session) {
    start_button <- shiny$reactive({
      input$start
    })
    next_button <- shiny$reactive({
      input$nextq
    })
    finish_button <- shiny$reactive({
      input$finish
    })

    timespan_reactive <- shiny$reactive({
      input$settime
    })


    key <- text_input$server("key")
    position <- text_input$server("position")
    job_desc <- text_input$server("job_desc")
    company <- text_input$server("company")
    experience <- text_input$server("experience")
    type <- itvw_type$server("itvw_type")


    data <- llm_action2$server(
      "out_ai", start_button, next_button,
      key, position, job_desc, company,
      type, experience
    )

    time_spent_df <- timer$server("timerid",
      timespan = timespan_reactive, start_button = start_button,
      next_button = next_button, finish_button = finish_button, key
    )


    histogram$server("hist", hist_df = time_spent_df)

    download$server("download", data, "questions.html", start_button, key)
    download$server("download_times", time_spent_df, "timespent.csv", finish_button, key)
  })
}
