PrincipleBranchAnswers <- runif(100, min = -1, max = 703)
PrincipleBranchTests <- PrincipleBranchAnswers * exp(PrincipleBranchAnswers)
SecondaryBranchAnswers <- runif(100, min = -703, max = -1)
SecondaryBranchTests <- SecondaryBranchAnswers * exp(SecondaryBranchAnswers)

context("Testing lambertW")

test_that("Functions return proper values", {
  expect_equal(lambertW0(PrincipleBranchTests), PrincipleBranchAnswers)
  expect_equal(lambertWm1(SecondaryBranchTests), SecondaryBranchAnswers)
})

test_that("NaNs are returned for values outside domain", {
  expect_true(is.nan(lambertW0(-1)))
  expect_true(is.nan(lambertWm1(-1)))
  expect_true(is.nan(lambertWm1(0)))
  expect_true(is.nan(lambertWm1(1)))
  expect_true(is.nan(lambertW0(c(1, -1)))[[2]])
})