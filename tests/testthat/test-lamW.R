PrincipleBranchAnswers <- runif(5000, min = -1, max = 703.22703310477016)
PrincipleBranchTests <- PrincipleBranchAnswers * exp(PrincipleBranchAnswers)
SecondaryBranchAnswers <- runif(5000, min = -714.96865723796657, max = -1)
SecondaryBranchTests <- SecondaryBranchAnswers * exp(SecondaryBranchAnswers)

test_that("Functions return proper values", {
  expect_equal(lambertW0(PrincipleBranchTests), PrincipleBranchAnswers)
  expect_equal(lambertWm1(SecondaryBranchTests), SecondaryBranchAnswers)
})

test_that("Function behaves properly near 0", {
  V0 <- seq(-2e-2, 2e-2, 2e-6)
  V0E <- V0 * exp(V0)
  LV0 <- lambertW0(V0E)
  expect_equal(V0, LV0)
})

test_that("W0 behaves properly VERY close to 0", {
  expect_equal(lambertW0(1e-275), 1e-275)
  expect_equal(lambertW0(7e-48), 7e-48)
  expect_equal(lambertW0(-3.81e-71), -3.81e-71)
})

test_that("Function behaves properly near -1/e", {
  expect_equal(lambertW0(-1/exp(1)), -1)
  expect_equal(lambertWm1(-1/exp(1)), -1)
})

test_that("Function behaves properly near asymptotes", {
  L <- seq(1e-6 - exp(-1), -0.25, 3e-6)
  V0 <- lambertW0(L)
  Vm1 <- lambertWm1(L)
  expect_equal(V0 * exp(V0), L)
  expect_equal(Vm1 * exp(Vm1), L)
  Vm1 <- seq(-714, -714.96865, -3e-5)
  Vm1E <- Vm1 * exp(Vm1)
  LVm1 <- lambertWm1(Vm1E)
  expect_equal(Vm1, LVm1)
})

test_that("Function behaves properly at asymptotes", {
  expect_equal(lambertW0(Inf), Inf)
  expect_equal(lambertWm1(0), -Inf)
})

test_that("NaNs are returned for values outside domain", {
  expect_true(is.nan(lambertW0(-Inf)))
  expect_true(is.nan(lambertWm1(-Inf)))
  expect_true(is.nan(lambertWm1(Inf)))
  expect_true(is.nan(lambertW0(-1)))
  expect_true(is.nan(lambertWm1(-1)))
  expect_true(is.nan(lambertWm1(1)))
  expect_true(is.nan(lambertW0(c(1, -1)))[[2]])
})

test_that("Integers are converted to reals for principle branch", {
  expect_equal(lambertW0(c(-1, 0, 1, 2, 3, 4)),
               lambertW0(c(-1L, 0L, 1L, 2L, 3L, 4L)))
})
