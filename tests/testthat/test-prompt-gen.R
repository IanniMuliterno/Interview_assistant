box::use(
  shiny[testServer],
  testthat[...],
)
box::use(
  app/logic/prompt_fun,
)

test_that("prompt_gen correctly combines input into a prompt", {
  expect_equal(
    prompt_fun$prompt_gen("Software Engineer", "develop software", "OpenAI", "HR", "experienced in AI development"),
    "Act as a job recruiter and enumerate some interview questions for me.\n    The position I'm applying for is Software Engineer in summary the description of the job is: develop software. The name of the company is OpenAI I want to practice for a interview with HR and here is my interview pitch 'experienced in AI development'. if you find that my pitch is not aligned with the position, make a research\n    and give me advice on how to update for better fit.\n    REMEMBER, ALWAYS ENUMERATE the questions and include your advive in the 'X awesome\n    advice X' section. Print in a way that looks good in the textOutput function from shiny"
  )
})
