lambertW0 <- function(x){
  if (!is.double(x)) {storage.mode(x) <- 'double'}
  .Call(lambertW0_C, x)
}

lambertWm1 <- function(x){
  if (!is.double(x)) {storage.mode(x) <- 'double'}
  .Call(lambertWm1_C, x)
}