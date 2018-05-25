---
title: "Function to import Meshlab picked points (*.pp) into R"
layout: post
date: 2017-05-07
tags: R geometric-morphometrics Meshlab 
comments: true
---



Recently, I've been using the 'PickPoints' feature of  [Meshlab](http://www.meshlab.net/) to collect landmarks from 3D surface models of primate skulls. Meshlab exports landmark coordinates in uniquely formatted 'PickedPoints' files, which I want to read into R as 3D coordinate matrices. Here is an example of the files I am working with- this one decribes 3 points, or landmarks, named "p1", "p2", and "p3":


```r
<!DOCTYPE PickedPoints>
<PickedPoints>
  <DocumentData>
    <DataFileName name="surface.ply"/>
    <templateName name="template.pptpl"/>
  </DocumentData>
  <point x="0.58" y="187.8" z="46.3" name="p1" active="1"/>
  <point x="0.09" y="169.2" z="31.9" name="p2" active="1"/>
  <point x="0.96" y="161.2" z="34.8" name="p3" active="1"/>
</PickedPoints>
```

For some reason, the order of the `<point/>` parameters, `x`, `y`, `z`, `name`, and `active`, varies unpredictably in saved `*.pp` files. Failure to recognize this quirk doomed my first attempt at writing an import function. Below is the successful version of the function,`read.pp`, for reading `*.pp` files into R.


```r
# function to read Meshlab *.pp files into R
read.pp <- function (file) {
	file <- readLines(file)
	lines <- file[grep("point", file)]
	x <- strsplit(lines, "x=\"")
	y <- strsplit(lines, "y=\"")
	z <- strsplit(lines, "z=\"")
	name <- strsplit(lines, "name=\"")
	mat <- matrix(0, length(x), 3)
	r <- c()
	for (i in 1:length(lines)) {
		mat[i,1] <- as.numeric(strsplit(x[[i]][2], "\"")[[1]][1])
		mat[i,2] <- as.numeric(strsplit(y[[i]][2], "\"")[[1]][1])
		mat[i,3] <- as.numeric(strsplit(z[[i]][2], "\"")[[1]][1])
		r <- c(r, strsplit(name[[i]][2], "\"")[[1]][1])
	}
	rownames(mat) <- r 
	colnames(mat) <- c("x","y","z")
	return(mat)
}
```

Import a single `*.pp` file like this:


```r
# import a single file
coords <- read.pp("~/path/to/file.pp")
```

To import a set of `*.pp` files from a directory and format them as a 3D array, use `read.pp` and `abind` in a loop: 


```r
# load abind package
library(abind)

# list all the *.pp files in the specified directory
path = "~/path/to/directory/"
files <- paste(path, list.files(path, ".pp"), sep="")

# loop to import each *.pp file and bind it to an array
landmarks <- NULL
for (i in 1:length(files)) {
  landmarks <- abind(landmarks, read.pp(files[i]), along=3)
}
```

And that's how you can pull your Meshlab landmarks into R!

**Footnotes:**

*The [`Morpho`](https://cran.r-project.org/web/packages/Morpho/index.html) package has the function [`read.mpp`](https://rdrr.io/cran/Morpho/man/read.mpp.html) for reading Meshlab picked points files into R, but it didn't work for me. Maybe the "picked points" output changed under more recent versions of Meshlab? I am currently using Meshlab 2016, which produces files with the extension `\*.pp`, not `\*.mpp`.*
