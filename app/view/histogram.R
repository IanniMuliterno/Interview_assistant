box::use(
  shiny[NS,moduleServer],
  echarts4r[e_histogram,e_charts,renderEcharts4r,echarts4rOutput,e_tooltip],
  
)

ui <- function(id) {
  ns <- NS(id)
  echarts4rOutput(ns("histogram"))

}

server <- function(id,hist_df) {
  moduleServer(
    id,
    function(input, output, session) {
      
      output$histogram <- renderEcharts4r( {
        
        df <- hist_df()
        if(nrow(df) > 1) {
          
          df |> 
            e_charts() |> 
            e_histogram(time_spent, name = 'histogram') |> 
            e_tooltip(trigger = 'axis') |> 
            e_title(("Candlestick chart for opening and closing prices")) |> 
            e_legend(show = FALSE)
          
        }
        
      })
      
    }
  )
}