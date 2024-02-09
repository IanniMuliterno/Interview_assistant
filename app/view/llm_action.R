box::use(
    shiny,
)

box::use(
    app/logic/prompt_fun
)


#' @export 
server <- function(id,start_btn,your_key,position_input,desc_input,company_input,type_input,exp_input) {
    shiny$moduleServer(
        id = id,
        module = function(session,input,output) {
          
          output_ai <- shiny$eventReactive(start_btn(),{
            
            combinedPrompt <- prompt_fun$prompt_gen(position_input(), desc_input(), company_input(), type_input(), exp_input())
              
            API_connection$your_llm(prompt = combinedPrompt(),your_bard_key = your_key())
              
            
          })
          
         
          
          return(output_ai)

        }
    )    
    

}