

prompt_gen <- function(position,desc,company,interview_type,exp) {

    prompt <- paste0("Act as a job recruiter and tailor some interview questions for me. The position I'm applying for is ",
    position, 
    " in summary the description of the job is: ",
    desc,
    ". The name of the company is ",
    company,
    " I want to practice for a interview with ",
    interview_type,
    " and here is my interview pitch '",
    exp,
    "'. if you find that my pitch is not aligned with the position, make a research and give me advice on how to update for better fit. 
    Always enumerate the questions and include your advive in the 'X awesome advice X' section. Print in a way that looks good in the textOutput function from shiny")

    return(prompt)

}

