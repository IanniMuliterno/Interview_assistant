box::use(
  shiny[actionButton, moduleServer, downloadHandler, NS, observeEvent],
  shinyjs[enable, disabled],
  markdown[markdownToHTML],
)

ui <- function(id, title) {
  ns <- NS(id)
  disabled(actionButton(ns("download"), title))
}

server <- function(id, data, archive_name, start) {
  moduleServer(
    id,
    function(input, output, session) {
      observeEvent(start(), {
        enable("download")
      })

      output$download <- downloadHandler(
        
        filename = ifelse(class(data()) == "list",
          paste0(archive_name, ".html"),
          paste0(archive_name, ".csv")
        ),
        content = function(file) {
          if (class(data()) == "character") {
            md_text <- paste(data())
            htmlText <- markdownToHTML(text = md_text, fragment.only = TRUE)
            writeLines(htmlText, con = file)
          } else {
            html_text <- write.csv(data())
            writeLines(html_text, con = file)
          }
        }
      )
    }
  )
}
