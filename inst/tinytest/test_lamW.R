# Copyright (c) 2015, Avraham Adler All rights reserved
# SPDX-License-Identifier: BSD-2-Clause

tol <- sqrt(.Machine$double.eps)
# Test that functions return proper values
principleBranchAnswers <- runif(5000, min = -1, max = 703.22703310477016)
principleBranchTests <- principleBranchAnswers * exp(principleBranchAnswers)
secondaryBranchAnswers <- runif(5000, min = -714.96865723796657, max = -1)
secondaryBranchTests <- secondaryBranchAnswers * exp(secondaryBranchAnswers)

# Test that function works properly in general
expect_equal(lambertW0(principleBranchTests), principleBranchAnswers,
             tolerance = tol)
expect_equal(lambertWm1(secondaryBranchTests), secondaryBranchAnswers,
             tolerance = tol)

# Test that function works properly for larger numbers
expect_equal(lambertW0(1000) * exp(lambertW0(1000)), 1000, tolerance = tol)

# Test that function behaves properly near 0
V0 <- seq(-2e-2, 2e-2, 2e-6)
V0E <- V0 * exp(V0)
expect_equal(lambertW0(V0E), V0, tolerance = tol)

# Test that W0 behaves properly VERY close to 0
expect_identical(lambertW0(1e-275), 1e-275)
expect_identical(lambertW0(7e-48), 7e-48)
expect_identical(lambertW0(-3.81e-71), -3.81e-71)

# Test that function behaves properly near -1/e
expect_identical(lambertW0(-1 / exp(1)), -1)
expect_identical(lambertWm1(-1 / exp(1)), -1)

# Test that function behaves properly near its asymptotes
L <- seq(1e-6 - exp(-1), -0.25, 3e-6)
V0 <- lambertW0(L)
vm1 <- lambertWm1(L)
expect_equal(V0 * exp(V0), L, tolerance = tol)
expect_equal(vm1 * exp(vm1), L, tolerance = tol)

vm1 <- seq(-714, -714.96865, -3e-5)
vm1E <- vm1 * exp(vm1)
expect_equal(lambertWm1(vm1E), vm1, tolerance = tol)

# Test that function behaves properly at its asymptotes
expect_identical(lambertW0(Inf), Inf)
expect_identical(lambertWm1(0), -Inf)

# Test that NaNs are returned for values outside domain
expect_true(is.nan(lambertW0(-Inf)))
expect_true(is.nan(lambertW0(-1)))
expect_true(is.nan(lambertW0(c(1, -1)))[[2]])
expect_true(is.nan(lambertWm1(-Inf)))
expect_true(is.nan(lambertWm1(Inf)))
expect_true(is.nan(lambertWm1(-0.5))) # x < -M_1_E
expect_true(is.nan(lambertWm1(1.2)))  # x > 0

# Test that integers are converted to reals for principle branch
expect_identical(lambertW0(c(-1L, 0L, 1L, 2L, 3L, 4L)),
                 lambertW0(c(-1, 0, 1, 2, 3, 4)))
