# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

lambertW0_C <- function(x) {
    .Call(`_lamW_lambertW0_C`, x)
}

lambertWm1_C <- function(x) {
    .Call(`_lamW_lambertWm1_C`, x)
}

# Register entry points for exported C++ functions
methods::setLoadAction(function(ns) {
    .Call(`_lamW_RcppExport_registerCCallable`)
})
