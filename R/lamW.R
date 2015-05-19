lambertW0 <- function(X){
  LAM <- double(length(X))
  LAM <- lambertW0_C(X)
  return(LAM)
}

lambertWm1 <- function(X){
  LAM <- double(length(X))
  LAM <- lambertWm1_C(X)
  return(LAM)
}