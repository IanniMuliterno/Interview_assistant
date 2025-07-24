box::use(
  httr,
  jsonlite,
  dplyr,
)

#' @export
your_llm <- function(prompt,
                     temperature = 0.5,
                     max_tokens = 1024,
                     groq_api_key,
                     model = "llama3-70b-8192") {
  
  url <- "https://api.groq.com/openai/v1/chat/completions"
  
  headers <- httr::add_headers(
    Authorization = paste("Bearer", groq_api_key),
    `Content-Type` = "application/json"
  )
  
  body <- list(
    model = model,
    messages = list(
      list(role = "user", content = prompt)
    ),
    temperature = temperature,
    max_tokens = max_tokens
  )
  
  response <- httr::POST(
    url = url,
    body = body,
    encode = "json",
    headers
  )
  
  if (response$status_code != 200) {
    stop(paste("Status Code -", response$status_code, "-", httr::content(response)$error$message))
  }
  
  result <- httr::content(response, as = "parsed")
  output <- result$choices[[1]]$message$content
  return(output)
}