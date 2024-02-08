box::use(
  shiny,
  bslib,
  lubridate,
)

box::use(
  app/view/itvw_type,
  app/view/text_input,
  app/view/timer,
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
        shiny$numericInput('settime','Seconds:',value=10,min=0,max=180,step=1),
        
      bslib$card()  
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
          
          shiny$actionButton("start","Tailor my questions"),
          shiny$actionButton("nextq","Ask next question"),
          shiny$actionButton("finish","Finish")
          
        ),
        
        bslib$layout_columns(
          bslib$card(
            full_screen = TRUE,
            bslib$card_header("your awesome output"),
            shiny$HTML(ns("message"))
            
          )
          
        ),
        
        bslib$layout_columns(
          
          
          bslib$card(
            full_screen = TRUE,
            bslib$card_header("Return")
          ),
          
          bslib$card(
            full_screen = TRUE,
            bslib$card_header("Timer")
            
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
    output$message <- shiny$renderText({
      
      "Alive!
Omnia

Allive!
Omnia
Hot like the sun
Wet like the rain
Green like the leaves
Life is a game
Stars in my head
Shine moon shine
Everything's cool
And I feel fine

Can you touch
The root that feed us
Can you hear
The words that i say
Can you feel
The music move you
Can you feel alive today"
      
    })
    
    timer$server("timerid",timespan = input$settime, start_button = input$start,
                 next_button = input$nextq,finish_button = input$finish)
    
  })
}
