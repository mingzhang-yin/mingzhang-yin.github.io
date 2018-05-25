# function to read in pp files exported from Meshlab's PickPoints module
# round=2 rounds landmarks to 2 decimal places
read.pp <- function (file, round=2) {
	file <- readLines(file)
	lines <- file[grep("point", file)]
	x <- strsplit(lines, "x=\"")
	y <- strsplit(lines, "y=\"")
	z <- strsplit(lines, "z=\"")
	name <- strsplit(lines, "name=\"")
	mat <- matrix(0, length(x), 3)
	r <- c()
	for (i in 1:length(lines)) {
		mat[i,1] <- round(as.numeric(strsplit(x[[i]][2], "\"")[[1]][1]), round)
		mat[i,2] <- round(as.numeric(strsplit(y[[i]][2], "\"")[[1]][1]), round)
		mat[i,3] <- round(as.numeric(strsplit(z[[i]][2], "\"")[[1]][1]), round)
		r <- c(r, strsplit(name[[i]][2], "\"")[[1]][1])
	}
	rownames(mat) <- r 
	colnames(mat) <- c("x","y","z")
	return(mat)
}