# Copyright (c) 2015, Avraham Adler All rights reserved
# SPDX-License-Identifier: BSD-2-Clause

# Only test at home. rhub valgrind complains and it should not affect covr.

if (Sys.info()["nodename"] == "HOME") {
  curPkg <- "lamW"
  pV <- packageVersion(curPkg)
  cit <- toBibtex(citation(curPkg))
  nws <- news(package = curPkg)
  myOtherPkgs <- c("Delaporte", "minimaxApprox", "Pade", "revss", "MBBEFDLite")

  # Test CITATION has most recent package version
  expect_true(any(grepl(pV, cit), fixed = TRUE))

  # Test NEWS has most recent package version
  expect_true(any(grepl(pV, nws, fixed = TRUE)))

  # Test that NEWS has an entry with DESCRIPTION's Date
  expect_true(any(grepl(packageDate(curPkg), nws, fixed = TRUE)))

  # Test that CITATION doesn't contain the name of any other of my packages
  expect_false(any(sapply(myOtherPkgs, grepl, x = cit, fixed = TRUE)))

  # Test that NEWS doesn't contain the name of any other of my packages
  expect_false(any(sapply(myOtherPkgs, grepl, x = nws, fixed = TRUE)))
}
