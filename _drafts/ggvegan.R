################
# Preparations #
################

# load packages
library("data.table") # for importing data from GitHub
library("vegan") # community ecology package
library("ggplot2")
#library("ggvegan)

# read data from GitHub
data <- data.frame(fread("https://raw.githubusercontent.com/rgriff23/Mosquito_ecology/master/Analysis/data.csv"), row.names = 1)

# make Habitat an ordered variable
data$Habitat <- ordered(data$Habitat, c("Field", "NearField", "Edge", "NearForest", "Forest"))

#############
# Analyses #
############

# mosquito abundance matrix
abundance.matrix <- data[,14:36]

# compute indices and add to new 'indices' data frame
indices <- data[,c("Region","Transect","Habitat")]
indices$Richness <- rowSums(abundance.matrix>0)
indices$Shannon <- diversity(abundance.matrix, index="shannon")
indices$Rarefied <- c(rarefy(abundance.matrix[1:45,], sample=15))

# ca, cca, pcca
abundance.matrix2 <- sqrt(abundance.matrix)/data$TrapNights
fixed <- data[,c(4,6,7,8)]
random <- data[,9:12]
my.ca <- cca(abundance.matrix2)
my.cca <- cca(abundance.matrix2, Y=fixed)
my.pcca <- cca(abundance.matrix2, Y=fixed, Z=random)


#########
# plots #
#########

# boxplots
data.box <- cbind(Habitat=rep(data$Habitat,3), stack(indices[,4:6]))
boxplot <- ggplot(data.box, aes(x = Habitat, y = values)) + 
  geom_boxplot(fill=rep(terrain.colors(6)[5:1],3)) +
  facet_wrap(~as.factor(ind), nrow=2, scales="free_y")
plot(boxplot)

# barchart for variance of CA explained
ca.bar <- data.frame(prop=my.ca$CA$eig/my.ca$CA$tot.chi, pc=as.factor(1:my.ca$CA$rank))
ggplot(ca.bar, aes(x=pc, y=prop)) +
  geom_col() + 
  xlab("CA axis") +
  ylab("Proportion of variance explained")

# biplots

#######
# End #
#######


