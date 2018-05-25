---
title: "Missing 3D landmarks in objects with bilateral symmetry: reflecting points across a plane" 
layout: post
date: 2017-06-09
tags: R geometric-morphometrics 
comments: true
---

I've been collecting 3D landmarks from the midline and right side of primate skulls, but damage sometimes prevents the collection of landmarks. I want to estimate the position of missing bilateral landmarks on the right side of the skull by placing the corresponding landmark on the left side of the skull and reflecting it across the saggital plane (i.e., the plane that divides the skull into symmetrical halves).

I wrote an R script to perform this task. The script first estimates the saggital plane using 3 or more landmarks on the midline of the skull, then reflects the specified bilateral landmarks across this plane. The function requires: 
1. A matrix of 3D landmark coordinates
2. A vector specifying at least three midline landmarks
3. A vector specifying at least one bilateral landmark to be reflected
The output is the same landmark coordinate matrix, except the old coordinates are replaced with the reflected ones. Here is the function:


```r
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
```

> Mathematical details: The saggital plane is defined by the mean of the midline landmarks (`m` - a point on the plane) and the third principal axis from a principal components analysis (`n` - a normalized normal vector for the plane). The quantity `d = sum(-m*n)` is the minimum distance from `m` to the plane passing through the origin with normal vector `n`. Using this information, we can translate the landmarks so that the saggital plane passes through the origin by adding vector `d*n` to each landmark. Translating the saggital plane to the origin allows us to use a [Householder transformation matrix](https://en.wikipedia.org/wiki/Householder_transformation), `A`, to reflect landmarks across the plane. To translate the reflected landmarks back to their original coordinate system, simply subtract the vector `d*n`. 

Below is a real example from my skull data. As you can see in the Meshlab viewer, there is damage to the right inferior orbit margin (the bottom of the eye), so I placed that point on the left side of the skull.

![](https://i.imgur.com/fLwt207.png)

Below, I load the `reflect.coords` function directly from GitHub along with another function, `read.pp`, which I wrote for importing Meshlab PickedPoints files:


```r
# load functions
source('https://raw.githubusercontent.com/rgriff23/rgriff23.github.io/master/assets/R/read.pp.R')
source('https://raw.githubusercontent.com/rgriff23/rgriff23.github.io/master/assets/R/reflect.coords.R')

# import landmarks into R
pp <- read.pp('https://raw.githubusercontent.com/rgriff23/rgriff23.github.io/master/assets/data/Cebuella_pygmaea_M_AMNH-M-76327_picked_points.pp')
pp
```

```
>                              x     y     z
>  Rhinion                 30.88 35.89 10.72
>  Prosthion               30.13 34.64  4.57
>  Infradentale            29.86 32.01  1.95
>  Gnathion                29.91 27.62  0.66
>  Canine (maxillary)      33.66 31.32  5.48
>  Canine (mandibular)     31.93 30.66  3.20
>  M2 (maxillary)          35.93 27.03  6.26
>  M2 (mandibular)         34.04 26.24  5.17
>  Gonion                  36.44 13.40  3.96
>  Coronion                40.12 21.67 10.12
>  Mandibular notch        39.73 17.76  9.72
>  Condylion               40.85 16.13 10.06
>  Porion                  40.13 14.10 12.70
>  Zygomatic point         42.26 19.49  9.17
>  Orbit margin (lateral)  42.24 29.26 13.96
>  Orbit margin (inferior) 24.21 30.55 10.20
>  Orbit margin (medial)   33.32 34.13 13.58
>  Orbit margin (superior) 37.45 33.07 17.84
>  Glabella                31.38 34.79 16.30
>  Frontotemporale         39.91 27.26 20.89
>  Euryon                  42.97 15.05 18.21
>  Vertex                  33.33 21.04 27.75
>  Opisthocranium          33.37  3.87 21.55
>  Opisthion               32.46  6.07 16.37
>  Basion                  31.51 10.34 11.85
>  Floor of sella          31.37 18.33 13.87
```

```r
# define midsaggital landmarks
midline <- c("Rhinion","Prosthion","Infradentale","Gnathion","Glabella", "Vertex", "Opisthocranium","Opisthion","Basion","Floor of sella")

# reflect inferior orbit landmark
pp.new <- reflect.coords(pp, midline, reflect="Orbit margin (inferior)")
pp.new
```

```
>                              x     y     z
>  Rhinion                 30.88 35.89 10.72
>  Prosthion               30.13 34.64  4.57
>  Infradentale            29.86 32.01  1.95
>  Gnathion                29.91 27.62  0.66
>  Canine (maxillary)      33.66 31.32  5.48
>  Canine (mandibular)     31.93 30.66  3.20
>  M2 (maxillary)          35.93 27.03  6.26
>  M2 (mandibular)         34.04 26.24  5.17
>  Gonion                  36.44 13.40  3.96
>  Coronion                40.12 21.67 10.12
>  Mandibular notch        39.73 17.76  9.72
>  Condylion               40.85 16.13 10.06
>  Porion                  40.13 14.10 12.70
>  Zygomatic point         42.26 19.49  9.17
>  Orbit margin (lateral)  42.24 29.26 13.96
>  Orbit margin (inferior) 37.33 30.97  8.61
>  Orbit margin (medial)   33.32 34.13 13.58
>  Orbit margin (superior) 37.45 33.07 17.84
>  Glabella                31.38 34.79 16.30
>  Frontotemporale         39.91 27.26 20.89
>  Euryon                  42.97 15.05 18.21
>  Vertex                  33.33 21.04 27.75
>  Opisthocranium          33.37  3.87 21.55
>  Opisthion               32.46  6.07 16.37
>  Basion                  31.51 10.34 11.85
>  Floor of sella          31.37 18.33 13.87
```

You can see that all of the landmarks are the same except for `Orbit margin (inferior)`, which changed from (24.21, 30.55, 10.20) to (37.33, 30.97, 8.61). I manually updated the Meshlab file with the coordinates of the reflected point in order to visualize the reflection:

![](https://i.imgur.com/RXu3Npk.png) 

It is important to visualize the reflected point to ensure that the placement is reasonable. For landmarks along the midline, or for lateral landmarks that lack a suitable mirror image (e.g., due to damage on the opposite side), [statistical interpolation](https://www.rdocumentation.org/packages/geomorph/versions/3.0.3/topics/estimate.missing) is an alternative approach to filling in missing landmarks (but this requires a sample of skulls). 

