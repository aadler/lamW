# Copyright (c) 2015, Avraham Adler All rights reserved
# SPDX-License-Identifier: BSD-2-Clause

pV <- packageVersion("lamW")

# Test CITATION has most recent package version
expect_true(any(grepl(pV, toBibtex(citation("lamW")), fixed = TRUE)))

# Test NEWS has most recent package version
expect_true(any(grepl(pV, news(package = "lamW"), fixed = TRUE)))

# Test that NEWS has an entry with DESCRIPTION's Date
expect_true(any(grepl(packageDate("lamW"), news(package = "lamW"),
                      fixed = TRUE)))
