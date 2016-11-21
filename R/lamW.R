lambertW0 <- function(x) {
  LAM <- double(length(x))
  LAM <- .Call(lambertW0_f_wrap, x)
  return (LAM)
}

lambertWm1 <- function(x){
  LAM <- double(length(x))
  LAM <- .Call(lambertWm1_f_wrap, x)
  return(LAM)
}
