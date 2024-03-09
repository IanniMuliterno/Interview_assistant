box::use(
  shiny[downloadButton, moduleServer, downloadHandler, NS, observeEvent],
  shinyjs[enable, disabled],
  markdown[markdownToHTML],
  utils[write.csv],
)

ui <- function(id, title) {
  ns <- NS(id)
  disabled(downloadButton(ns("download"), title))
}

server <- function(id, data, archive_name, start) {
  moduleServer(
    id,
    function(input, output, session) {
      observeEvent(start(), {
        enable("download")
      })

      output$download <- downloadHandler(
        filename = function() {
          paste(archive_name)
        },
        content = function(file) {
          if (class(data()) == "character") {
            md_text <- paste(data())
            htmlText <- markdownToHTML(text = md_text, fragment.only = TRUE)
            writeLines(htmlText, con = file)
          } else {
            write.csv(data(), file)
          }
        }
      )
    }
  )
}
