# function to reflect 3D points across the plane of symmetry of an object
reflect.coords <- function (mat, midline, reflect) {
  
  # definitions
  m <- colMeans(mat[midline,]) # mean of midline points
  n <- prcomp(mat[midline,])$rotation[,3] # normal to saggital plane
  d <- sum(-m*n) # distance to translate points
  A <- diag(3) - 2*n%*%t(n) # Householder transformation matrix
  
  # translate saggital plane to origin and reflect points 
  r <-  t(mat[reflect,]) + d*n 
  z <- ifelse(nrow(r)==1, 1, 2) 
  r <- t(apply(r, z, function(x) A%*%x))
  
  # reverse-translate and substitute back into matrix
  mat[reflect,] <- r  - d*n
  
  # return rounded matrix
  return(round(mat, 2))
}

# example usage
#mat <- matrix(c(0,2,0,0,2,1,0,0,2,0,-1,1,3,0,0,2,0,1), nrow=6,ncol=3, byrow=T, dimnames=list(c("m1","m2","m3","m4","b1","b2"), c("x","y","z")))
#midline <- c("m1","m2","m3","m4")
#reflect <- c("b1","b2")
#reflect.coords(mat, midline, reflect)