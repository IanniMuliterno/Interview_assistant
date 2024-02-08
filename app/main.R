box::use(
  shiny,
  bslib,
)

box::use(
  app/view/itvw_type,
  app/view/text_input,
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
          
          shiny$actionButton("start","Tailor my questions"),
          shiny$actionButton("next","Ask next question"),
          shiny$actionButton("finish","Finish")
          
        ),
        
        bslib$layout_columns(
          bslib$card(
            full_screen = TRUE,
            bslib$card_header("your awesome output"),
            shiny$HTML(ns("message"))
            
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
Can you feel alive today

Vana dea dzjo vana dea
La vana do aribedibeda
Vana dea dzjo vana dea
La vana do aribeda
Vana dea dzjo vana dea
La vana do aribedibeda
Vana dea dzjo vana dea
La vana do aribeda

Falledal do
Falledal dea
Falledal do
Falledal da
Falledaldea
Ya vana dea ribeda

Can you touch
The root that feed us
Can you hear
The words that i say
Can you feel
The music move you
Can you feel alive today

Vana dea dzjo vana dea
La vana do aribedibeda
Vana dea dzjo vana dea
La vana do aribeda
Vana dea dzjo vana dea
La vana do aribedibeda
Vana dea dzjo vana dea
La vana do aribeda

Falledal do
Falledal dea
Falledal do
Falledal da
Falledaldea
Ya vana dea ribeda

Can you touch
The root that feed us
Can you hear
The words that i say
Can you feel
The music move you
Can you feel alive today

Can you feel alive
Can you feel alive
Can you feel alive

Strong like the grass
Tall like a tree
Free like the wind
Eternally
Nothing to lose
Nothing to gain
Just running wyld
Again and again and again

Can you touch
The root that feed us
Can you hear
The words that i say
Can you feel
The music move you
Can you feel alive today

Falledal do
Falledal dea
Falledal do
Falledal da
Falledaldea
Ya vana dea ribeda

Bumblebees and blossom
Only trees and me
Humble bees and blossom
Only trees and me"
      
    })
  })
}
