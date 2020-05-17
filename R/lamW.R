lambertW0 <- function(x) {
  if (!is.double(x)) {storage.mode(x) <- 'double'}
  LAM <- double(length(x))
  LAM <- .Call(lambertW0_f_wrap, x)
  return(LAM)
}

lambertWm1 <- function(x){
  if (!is.double(x)) {storage.mode(x) <- 'double'}
  LAM <- double(length(x))
  LAM <- .Call(lambertWm1_f_wrap, x)
  return(LAM)
}
