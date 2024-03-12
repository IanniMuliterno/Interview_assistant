box::use(
  shiny[downloadButton, moduleServer, downloadHandler, NS, observeEvent, validate, need, ],
  shinyjs[enable, disabled],
  markdown[markdownToHTML],
  utils[write.csv],
)

ui <- function(id, title) {
  ns <- NS(id)
  disabled(downloadButton(ns("download"), title))
}

server <- function(id, data, archive_name, start, your_key) {
  moduleServer(
    id,
    function(input, output, session) {
      observeEvent(start(), {
        validate(
          need(your_key$value() != "", "Please enter your bard key.")
        )

        enable("download")
      })

      output$download <- downloadHandler(
        filename = function() {
          paste(archive_name)
        },
        content = function(file) {
          if (class(data()) == "character") {
            md_text <- paste(data())
            html_text <- markdownToHTML(text = md_text, fragment.only = TRUE)
            writeLines(html_text, con = file)
          } else {
            write.csv(data(), file)
          }
        }
      )
    }
  )
}
