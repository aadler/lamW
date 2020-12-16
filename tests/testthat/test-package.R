test_that("Version", {
  expect_match(toBibtex(citation('lamW')),
               as.character(packageVersion('lamW')),
               fixed = TRUE, all = FALSE)
})
