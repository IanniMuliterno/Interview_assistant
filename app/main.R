box::use(
  shiny,
  bslib,
  lubridate,
)

box::use(
  app/view/itvw_type,
  app/view/text_input,
  app/view/timer,
  app/view/llm_action2,
)

#' @export
ui <- function(id) {
  ns <- shiny$NS(id)
  shiny$fluidPage(
    theme = bslib$bs_theme(bootswatch = "darkly"),
    
    shiny$sidebarLayout(
      
      shiny$sidebarPanel(
        text_input$ui(
          id = ns("key"),
          "Bard key",
          "insert your bard key"
        ),
        shiny$numericInput(ns('settime'),'Seconds:',value=180,min=0,max=180,step=1),
        
      bslib$card(
        
        full_screen = FALSE,
        bslib$card_header("Directions"),
        shiny$HTML("Maximize your interview impact in just 3 minutes. 'interviewpro.ai' guides you to concise and compelling self-presentation. Perfect your pitch with us.")
        
      )  
      ),
      
      shiny$mainPanel(
        
        
        bslib$layout_columns(
          itvw_type$ui(
            id = ns("itvw_type"),
            input_title = "Who is interviewing you",
            choice_list = c("HR","Tech manager")
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
          
          shiny$actionButton(ns("start"),"Tailor my questions"),
          shiny$actionButton(ns("nextq"),"Ask next question"),
          shiny$actionButton(ns("finish"),"Finish")
          
        ),
        
        bslib$layout_columns(
          bslib$card(
            full_screen = TRUE,
            bslib$card_header("your awesome output"),
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
  shiny$moduleServer(id, function(input, output, session) {
    
    startButtonClick <- shiny$reactive({ input$start })
    nextButtonClick <- shiny$reactive({ input$nextq })
    finishButtonClick <- shiny$reactive({ input$finish })
    
    position <- text_input$server("position")
    job_desc <- text_input$server("job_desc")
    company <- text_input$server("company")
    experience <- text_input$server("experience")
    key <- text_input$server("key")
    type <- itvw_type$server("itvw_type")
    
    
  llm_action2$server("out_ai",startButtonClick, key, position, job_desc, company, experience, type)
    
    
    timer$server("timerid",timespan = input$settime, start_button = startButtonClick,
                 next_button = nextButtonClick,finish_button = finishButtonClick)
    
    # output$circle_time <- shiny$renderImage({
    #   
    #   list(src = "app/img/Green_circle_3_4.png")
    #   
    # }, deleteFile = F)
    
    
    
  })
}
