box::use(
    shiny,
)

box::use(
    app/logic/prompt_fun
)

#' @export 
ui <- function(id) {
    ns <- NS(id)
    shiny$HTML("output_ai")
}




#' @export 
server <- function(id,your_key,position_input,desc_input,company_input,type_input,exp_input) {
    moduleServer(
        id = id,
        module = function(session,input,output) {
          
          output$output_ai <- ({
            
            your_prpt <- prompt_gen(position_input(),desc_input(),company_input(),type_input(),exp_input())
            API_connection$your_llm(prompt = your_prpt,your_bard_key = your_key)
            
          })

            

        }
    )    
    

}