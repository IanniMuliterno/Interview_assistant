box::use(
  httr,
  jsonlite,
  dplyr,
)

#' @export
your_llm <- function(prompt,
                     temperature = 0.5,
                     max_output_tokens = 1024,
                     your_bard_key,
                     model = "gemini-pro") {
  model_query <- paste0(model, ":generateContent")
  
  response <- httr$POST(
    url = paste0("https://generativelanguage.googleapis.com/v1beta/models/", model_query),
    query = list(key = your_bard_key),
    httr$content_type_json(),
    encode = "json",
    body = list(
      contents = list(
        parts = list(
          list(text = prompt)
        )
      ),
      generationConfig = list(
        temperature = temperature,
        maxOutputTokens = max_output_tokens
      )
    )
  )
  if (response$status_code > 200) {
    stop(paste("Status Code - ", response$status_code))
  }
  candidates <- httr$content(response)$candidates
  outputs <- unlist(lapply(candidates, function(candidate) candidate$content$parts))
  return(outputs)
}
