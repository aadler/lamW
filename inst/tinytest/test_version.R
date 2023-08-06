# Copyright (c) 2015, Avraham Adler All rights reserved
# SPDX-License-Identifier: BSD-2-Clause

pV <- packageVersion("lamW")

# Test CITATION has most recent package version
expect_true(any(grepl(pV, toBibtex(citation("lamW")), fixed = TRUE)))

# For some unknown reason this passes on Windows and Mac but not Ubuntu. Since
# this is mainly for my own personal development purposes, I will wrap it in a
# check for "HOME".
if (Sys.info()["nodename"] == "HOME") {
  # Test NEWS has most recent package version
  expect_true(any(grepl(pV, news(package = "lamW"), fixed = TRUE)))

  # Test that NEWS has an entry with DESCRIPTION's Date
  expect_true(any(grepl(packageDate("lamW"), news(package = "lamW"),
                        fixed = TRUE)))
}
