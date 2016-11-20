lambertW0 <- function(x) {
  LAM <- double(length(x))
  LAM <- .Call('lambertW0_f_wrap', x, PACKAGE = 'lamW')
  return (LAM)
}

lambertWm1 <- function(x){
  LAM <- double(length(x))
  LAM <- .Call('lambertWm1_f_wrap', x, PACKAGE = 'lamW')
  return(LAM)
}

halley <- function(x, w){
  .Call('h_wrap', x, w, PACKAGE = 'lamW')
}

lambertW0s <- function(x) {
  LAM <- double(length(x))
  LAM <- .Call('lambertW0_f_s_wrap', x, PACKAGE = 'lamW')
  return (LAM)
}