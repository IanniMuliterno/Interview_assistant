box::use(
  
  shiny[actionButton,moduleServer,downloadHandler]
  
)

ui <- function(id, title) {
  ns <- NS(id)
  actionButton(ns("download"), title)
}

server <- function(id,data,archive_name) {
  moduleServer(
    id,
    function(input, output, session) {
      
      output$download <- downloadHandler(
        filename = archive_name,
        content = function(file) {
          write.csv(data, file)
        }
      )
    }
      
  )
}