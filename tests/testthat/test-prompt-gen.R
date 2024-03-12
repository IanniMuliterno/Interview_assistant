box::use(
  shiny[testServer],
  testthat[...],
)
box::use(
  app/logic/prompt_fun,
)

test_that("prompt_gen correctly combines input into a prompt", {
  expect_true(
    grepl("Software Engineer", prompt_fun$prompt_gen("Software Engineer",
                                                     "develop software", "OpenAI",
                                                     "HR", "experienced in AI development"))
  )
})
