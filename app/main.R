box::use(
  shiny,
  bslib,
)

box::use(
  app / view / itvw_type,
  app / view / text_input,
  app / view / timer,
  app / view / llm_action2,
)

#' @export
ui <- function(id) {
  ns <- shiny$NS(id)
  shiny$fluidPage(
    theme = bslib$bs_theme(),
    shiny$sidebarLayout(
      shiny$sidebarPanel(
        text_input$ui(
          id = ns("key"),
          "Bard key",
          "insert your bard key"
        ),
        shiny$numericInput(ns("settime"), "Seconds:", value = 180, min = 0, max = 180, step = 1),
        bslib$card(
          full_screen = FALSE,
          bslib$card_header("Directions"),
          shiny$HTML("Maximize your interview impact. Everything you need is to generate a bard key and 'interviewpro.ai' will guide you to concise and compelling self-presentation.
                   <p>Find your own Bard API by following the instructions here: <a href='https://www.cloudbooklet.com/ai-text/googles-bard-api-key/' target='_blank'>https://www.cloudbooklet.com/ai-text/googles-bard-api-key/</a></p>")
        )
      ),
      shiny$mainPanel(
        bslib$layout_columns(
          itvw_type$ui(
            id = ns("itvw_type"),
            input_title = "Who is interviewing you",
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
          bslib$card(
            full_screen = TRUE,
            bslib$card_header("Return")
          ),
          bslib$card(
            full_screen = TRUE,
            bslib$card_header("Timer"),
            # shiny$imageOutput(ns("circle_time")),
            timer$ui(ns("timerid"))
          ),
          bslib$card(
            full_screen = TRUE,
            bslib$card_header("Results")
          )
        )
      )
    )
  )
}

#' @export
server <- function(id) {
  bslib::bs_themer()

  shiny$moduleServer(id, function(input, output, session) {
    startButtonClick <- shiny$reactive({
      input$start
    })
    nextButtonClick <- shiny$reactive({
      input$nextq
    })
    finishButtonClick <- shiny$reactive({
      input$finish
    })

    key <- text_input$server("key")
    position <- text_input$server("position")
    job_desc <- text_input$server("job_desc")
    company <- text_input$server("company")
    experience <- text_input$server("experience")
    type <- itvw_type$server("itvw_type")


    llm_action2$server(
      "out_ai", startButtonClick, nextButtonClick,
      key, position, job_desc, company,
      type, experience
    )

    timespanReactive <- shiny$reactive({
      input$settime
    })


    timer$server("timerid",
      timespan = timespanReactive, start_button = startButtonClick,
      next_button = nextButtonClick, finish_button = finishButtonClick
    )

    # output$circle_time <- shiny$renderImage({
    #
    #   list(src = "app/img/Green_circle_3_4.png")
    #
    # }, deleteFile = F)
  })
}
