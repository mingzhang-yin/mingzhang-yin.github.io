# arguments:
## site: path from MACHINE ROOT to site (include final slash)
## file: path from SITE ROOT to the *.Rmd you are knitting
## figs: path from SITE ROOT where *.md looks for figures

knitshit <- function (site, file, figs) {
  
  # extract separate rmd file name from the path
  div <- strsplit(file, "/")[[1]]
  rmd <- tail(div, 1)
  move <- paste0(site, div[1:(length(div)-1)], collapse="/")
  
  # current directory
  current <- getwd()
  
  # move
  setwd(move)
  
  # set knitr parameters
  opts_knit$set(base.dir = site, base.url = "/")
  opts_chunk$set(fig.path = figs) 
  
  # knit
  knit(rmd)
  
  # return knitr parameters to defaults
  opts_knit$set(base.dir = NULL, base.url = NULL)
  opts_chunk$set(fig.path = "figure/")
  
  # return to original directory
  setwd(current)
}

# example usage
# file = "projects/file.Rmd"
# site = "/Users/nunnlab/Desktop/GitHub/rgriff23.github.io/"
# figs = "assets/Rfigs/"
# knitshit(file = file, site = site, figs = figs)
