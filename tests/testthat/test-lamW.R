PrincipleBranchAnswers <- c(seq_len(100) - 1, pi, exp(1), 17.5, 150, 700)
PrincipleBranchTests <- PrincipleBranchAnswers * exp(PrincipleBranchAnswers)
SecondaryBranchAnswers <- c(-seq_len(25) / 2 - 0.5)
SecondaryBranchTests <- SecondaryBranchAnswers * exp(SecondaryBranchAnswers)

context("Testing lambertW")

test_that("Functions return proper values", {
  expect_that(lambertW0(PrincipleBranchTests), equals(PrincipleBranchAnswers))
  expect_that(lambertWm1(SecondaryBranchTests), equals(SecondaryBranchAnswers))
})

test_that("NaNs are returned for values outside domain", {
  expect_true(is.nan(lambertW0(-1)))
  expect_true(is.nan(lambertWm1(-1)))
  expect_true(is.nan(lambertWm1(0)))
  expect_true(is.nan(lambertWm1(1)))
  expect_true(is.nan(lambertW0(c(1, -1)))[[2]])
})