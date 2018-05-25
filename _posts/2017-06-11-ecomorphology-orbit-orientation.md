---
title: "Orbit orientation isn't correlated with anything: a reanalysis of Heesy (2008)"
layout: post
date: 2017-06-11
tags: R evolution primates mammals morphology phylogeny geiger geomorph
comments: true
---



In this post, I re-analyze data from a paper, ["Ecomorphology of orbit orientation and the adaptive significance of binocular vision in primates and other mammals"](http://www.karger.com/Article/Abstract/108621) by Chris Heesy (2008). My main finding is that correcting for the statistical non-independence of species data undermines the paper's major conclusions, and I highlight directions for future work.   

## The ecomorphology of orbit orientation (Heesy 2008)

"Forward-facing orbits", or the tendancy of the orbits of the skull to face forwards, are part of the suite of characteristics that differentiate the first primates from other early mammals. Other differentiating characteristics include hand and foot adaptations for grasping, hindlimb and ankle modifications for leaping, and dental features associated with eating more fruit than their predecessors. 

Several hypotheses propose that orbit convergence was functionally important for early primates. The *Grasp-Leaping Hypothesis* posits that convergent orbits evolved to facilitate depth perception during rapid leaping in an arboreal environment (Szalay and Dagosto 1980). Several versions of the *Angiosperm Diversification Hypothesis* propose that convergent orbits facilitated visually directed feeding on fruits or insects on the terminal branches of angiosperms (e.g., Rasmussen 1990; Sussman 1991). Finally, the *Nocturnal Visual Predation Hypothesis* proposes that convergent orbits evolved to facilitate visually guided predation in a low-light environment (Cartmill 1992).

In a 2008 [study](http://www.karger.com/Article/Abstract/108621), Chris Heesy analyzed a large dataset on orbit orientation and ecological variables in mammals. From his analysis, he concluded that "These data are entirely consistent with the nocturnal visual predation hypothesis of primate origins." Below, I describe and reproduce Heesy's (2008) study using data that was published along with the paper. I discuss Heesy's results, then show how incorporating data on phylogenetic relationships into the error structure of the statistical models undermines the paper's major conclusions.

Heesy (2008) considered three ecological variables as potential predictors of orbit orientation across mammals: activity pattern (nocturnal = 1, other = 0), diet (insectivory = 1, other = 0), and substrate use (arboreal = 1, other = 0). He captured orbit orientation with three angles measured on the skull: convergence, frontation, and verticality. The lines and planes used for computing these angles are diagrammed in the figure below (taken from Heesy 2008):

![](http://i.imgur.com/9RhjfDi.png)

> **Technical notes on quantifying orbit orientation**: *Orbit convergence* is measured by the angle between the saggital and orbital planes, the latter being defined by the 3 points: OA- anterior orbit margin, OI- inferior orbit margin, and OS- superior orbit margin (this is shown in figure **a** above). *Orbit frontation* is measured by the angle between the line formed by the intersection of the saggital and orbital planes (shown in figure **b** above), and the inion-nasion line (not shown), which essentially runs along the midline from the back of the braincase through the forehead. *Orbit verticality* is the angle between the orbital plane and the palatal plane (formed by the prosthion and the midpoints of the M1 alveolar borders). All three of these measures capture the extent to which the orbits face 'forwards'. 

Heesy (2008) assessed the relationship between orbit orientation and ecological variables using MANOVA, with orbit convergence, frontation, and verticality as a multivariate response variable, and nocturnality, insectivory, and arboreality as binary predictor variables (plus interaction terms). This is the full model:

> [convergence, frontation, verticality] ~ nocturnality \* insectivory \* arboreality

In addition to MANOVA, one-way ANOVAs were performed for pairs of independent and dependent variables.

To address the concern that certain taxonomic groups might be driving the results, Heesy repeated all analyses on two subsets of the data: 1) mammals excluding marsupials and anthropoid primates, and 2) mammals excluding marsupials and all primates. These particular groups were removed because it was argued that marsupials and primates (and especially anthropoids) have either special morphological constraints or highly derived orbit morphology. 

Now I will replicate Heesy's analysis using the data from the paper, with the slight difference that I dropped 35 of Heesy's original 331 taxa because they lacked phylogenetic data. I did this in order to facilitate a direct comparison between the results of phylogenetic and non-phylogenetic analyses. As the R code below demonstrates, my non-phylogenetic results are highly consistent with what Heesy (2008) reported in Table 1 of his paper, despite the removal of 35 taxa. First, here are the MANOVA and ANOVA results for all primates (note that the first table of results is for the MANOVA, which considers all the orbit measurements together as a multivariate response variable, and the next three tables of results are for ANOVAs of each orbit measurement separately): 


```r
# import data
data <- read.csv("https://raw.githubusercontent.com/rgriff23/Heesy_2008_reanalysis/master/data/HeesyData.csv", header=TRUE, row.names=1)

# MANOVA/ANOVA (all taxa)
heesy.model.1 <- manova(cbind(Convergence, Frontition, Verticality) ~ Noccode*Fauncode*Arbcode, data=data)
summary.manova(heesy.model.1, test="Wilks")
```

```
>                            Df   Wilks approx F num Df den Df    Pr(>F)    
>  Noccode                    1 0.58495   65.989      3    279 < 2.2e-16 ***
>  Fauncode                   1 0.90222   10.079      3    279 2.516e-06 ***
>  Arbcode                    1 0.76720   28.220      3    279 5.740e-16 ***
>  Noccode:Fauncode           1 0.90691    9.546      3    279 5.072e-06 ***
>  Noccode:Arbcode            1 0.90855    9.361      3    279 6.467e-06 ***
>  Fauncode:Arbcode           1 0.96236    3.638      3    279   0.01331 *  
>  Noccode:Fauncode:Arbcode   1 0.97735    2.155      3    279   0.09357 .  
>  Residuals                281                                             
>  ---
>  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
summary.aov(heesy.model.1)
```

```
>   Response Convergence :
>                            Df Sum Sq Mean Sq F value    Pr(>F)    
>  Noccode                    1   2127  2127.1 11.0809 0.0009886 ***
>  Fauncode                   1   2329  2328.6 12.1307 0.0005750 ***
>  Arbcode                    1  14800 14800.3 77.1018 < 2.2e-16 ***
>  Noccode:Fauncode           1   2211  2211.0 11.5183 0.0007883 ***
>  Noccode:Arbcode            1   3528  3528.3 18.3807 2.489e-05 ***
>  Fauncode:Arbcode           1    467   467.0  2.4330 0.1199305    
>  Noccode:Fauncode:Arbcode   1   1154  1154.4  6.0138 0.0148029 *  
>  Residuals                281  53940   192.0                      
>  ---
>  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
>  
>   Response Frontition :
>                            Df Sum Sq Mean Sq F value    Pr(>F)    
>  Noccode                    1   6481  6480.9 22.8581 2.817e-06 ***
>  Fauncode                   1   8092  8092.4 28.5416 1.897e-07 ***
>  Arbcode                    1   5290  5290.5 18.6592 2.170e-05 ***
>  Noccode:Fauncode           1   3245  3244.8 11.4443 0.0008191 ***
>  Noccode:Arbcode            1   1772  1772.1  6.2503 0.0129875 *  
>  Fauncode:Arbcode           1    330   329.6  1.1624 0.2818935    
>  Noccode:Fauncode:Arbcode   1    684   683.8  2.4118 0.1215460    
>  Residuals                281  79672   283.5                      
>  ---
>  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
>  
>   Response Verticality :
>                            Df  Sum Sq Mean Sq  F value    Pr(>F)    
>  Noccode                    1 13352.4 13352.4 146.8381 < 2.2e-16 ***
>  Fauncode                   1  1095.5  1095.5  12.0479  0.000600 ***
>  Arbcode                    1   900.4   900.4   9.9013  0.001829 ** 
>  Noccode:Fauncode           1  1676.3  1676.3  18.4341 2.424e-05 ***
>  Noccode:Arbcode            1   831.8   831.8   9.1478  0.002720 ** 
>  Fauncode:Arbcode           1     8.6     8.6   0.0948  0.758401    
>  Noccode:Fauncode:Arbcode   1    72.8    72.8   0.8002  0.371798    
>  Residuals                281 25552.1    90.9                       
>  ---
>  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
>  
>  7 observations deleted due to missingness
```
Now here are MANOVA and ANOVA results after dropping marsupials and anthropoids:


```r
# MANOVA/ANOVA (drop marsupials and anthropoids)
data.eu1 <- data[!(data$ORDER%in%c("Didelphimorphia","Diprotodontia")),]
data.eu1 <- data.eu1[data.eu1$GROUP != "Anthropoidea",]
heesy.model.2 <- manova(cbind(Convergence, Frontition, Verticality) ~ Noccode*Fauncode*Arbcode, data=data.eu1)
summary.manova(heesy.model.2, test="Wilks")
```

```
>                            Df   Wilks approx F num Df den Df    Pr(>F)    
>  Noccode                    1 0.81984  14.7233      3    201 1.052e-08 ***
>  Fauncode                   1 0.85352  11.4989      3    201 5.454e-07 ***
>  Arbcode                    1 0.82560  14.1532      3    201 2.094e-08 ***
>  Noccode:Fauncode           1 0.99298   0.4740      3    201   0.70076    
>  Noccode:Arbcode            1 0.99016   0.6656      3    201   0.57409    
>  Fauncode:Arbcode           1 0.95657   3.0416      3    201   0.03002 *  
>  Noccode:Fauncode:Arbcode   1 0.98757   0.8435      3    201   0.47153    
>  Residuals                203                                             
>  ---
>  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
summary.aov(heesy.model.2)
```

```
>   Response Convergence :
>                            Df  Sum Sq Mean Sq F value    Pr(>F)    
>  Noccode                    1  3045.9 3045.94 26.3461 6.660e-07 ***
>  Fauncode                   1   265.5  265.52  2.2966    0.1312    
>  Arbcode                    1  2977.6 2977.55 25.7545 8.738e-07 ***
>  Noccode:Fauncode           1     0.0    0.01  0.0001    0.9929    
>  Noccode:Arbcode            1   142.5  142.53  1.2328    0.2682    
>  Fauncode:Arbcode           1   101.0  101.02  0.8738    0.3510    
>  Noccode:Fauncode:Arbcode   1   278.8  278.82  2.4117    0.1220    
>  Residuals                203 23469.4  115.61                      
>  ---
>  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
>  
>   Response Frontition :
>                            Df Sum Sq Mean Sq F value    Pr(>F)    
>  Noccode                    1   1050  1049.6  4.2153 0.0413431 *  
>  Fauncode                   1   3713  3713.1 14.9129 0.0001513 ***
>  Arbcode                    1   1459  1459.0  5.8599 0.0163698 *  
>  Noccode:Fauncode           1     10    10.5  0.0420 0.8378744    
>  Noccode:Arbcode            1      4     4.5  0.0180 0.8934182    
>  Fauncode:Arbcode           1    415   414.6  1.6653 0.1983630    
>  Noccode:Fauncode:Arbcode   1     98    98.4  0.3953 0.5302118    
>  Residuals                203  50545   249.0                      
>  ---
>  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
>  
>   Response Verticality :
>                            Df  Sum Sq Mean Sq F value    Pr(>F)    
>  Noccode                    1  1142.0 1142.00 18.4649 2.684e-05 ***
>  Fauncode                   1   205.3  205.35  3.3202    0.0699 .  
>  Arbcode                    1    47.3   47.35  0.7656    0.3826    
>  Noccode:Fauncode           1    44.4   44.36  0.7172    0.3981    
>  Noccode:Arbcode            1    94.9   94.92  1.5348    0.2168    
>  Fauncode:Arbcode           1     1.8    1.83  0.0296    0.8635    
>  Noccode:Fauncode:Arbcode   1    34.5   34.47  0.5574    0.4562    
>  Residuals                203 12555.0   61.85                      
>  ---
>  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
>  
>  4 observations deleted due to missingness
```
And finally, here are MANOVA and ANOVA results after dropping marsupials and all primates:


```r
# MANOVA/ANOVA (drop marsupials and all primates)
data.eu2 <- data[!(data$ORDER%in%c("Didelphimorphia","Diprotodontia","Primates")),]
heesy.model.3 <- manova(cbind(Convergence, Frontition, Verticality) ~ Noccode*Fauncode*Arbcode, data=data.eu2)
summary.manova(heesy.model.3, test="Wilks")
```

```
>                            Df   Wilks approx F num Df den Df    Pr(>F)    
>  Noccode                    1 0.74583  18.6298      3    164 1.896e-10 ***
>  Fauncode                   1 0.79615  13.9969      3    164 3.610e-08 ***
>  Arbcode                    1 0.91804   4.8804      3    164  0.002816 ** 
>  Noccode:Fauncode           1 0.98138   1.0374      3    164  0.377606    
>  Noccode:Arbcode            1 0.95960   2.3013      3    164  0.079143 .  
>  Fauncode:Arbcode           1 0.95074   2.8325      3    164  0.040024 *  
>  Noccode:Fauncode:Arbcode   1 0.99085   0.5049      3    164  0.679449    
>  Residuals                166                                             
>  ---
>  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
summary.aov(heesy.model.3)
```

```
>   Response Convergence :
>                            Df  Sum Sq Mean Sq F value    Pr(>F)    
>  Noccode                    1  4128.8  4128.8 40.6434 1.738e-09 ***
>  Fauncode                   1  1219.4  1219.4 12.0035 0.0006758 ***
>  Arbcode                    1     4.8     4.8  0.0471 0.8283762    
>  Noccode:Fauncode           1   134.8   134.8  1.3273 0.2509418    
>  Noccode:Arbcode            1   307.5   307.5  3.0270 0.0837449 .  
>  Fauncode:Arbcode           1    78.2    78.2  0.7702 0.3814214    
>  Noccode:Fauncode:Arbcode   1     3.7     3.7  0.0368 0.8480499    
>  Residuals                166 16863.2   101.6                      
>  ---
>  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
>  
>   Response Frontition :
>                            Df Sum Sq Mean Sq F value   Pr(>F)   
>  Noccode                    1   1770 1769.56  6.7530 0.010201 * 
>  Fauncode                   1   2337 2336.91  8.9182 0.003251 **
>  Arbcode                    1    167  166.72  0.6363 0.426210   
>  Noccode:Fauncode           1    134  134.20  0.5121 0.475219   
>  Noccode:Arbcode            1    411  411.20  1.5692 0.212079   
>  Fauncode:Arbcode           1    733  733.22  2.7981 0.096259 . 
>  Noccode:Fauncode:Arbcode   1    167  167.28  0.6384 0.425434   
>  Residuals                166  43499  262.04                    
>  ---
>  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
>  
>   Response Verticality :
>                            Df  Sum Sq Mean Sq F value    Pr(>F)    
>  Noccode                    1  1074.2 1074.19 16.6869 6.846e-05 ***
>  Fauncode                   1   301.2  301.16  4.6783   0.03198 *  
>  Arbcode                    1   105.8  105.76  1.6430   0.20171    
>  Noccode:Fauncode           1    48.5   48.50  0.7534   0.38667    
>  Noccode:Arbcode            1    37.6   37.61  0.5843   0.44571    
>  Fauncode:Arbcode           1    22.2   22.16  0.3442   0.55820    
>  Noccode:Fauncode:Arbcode   1    59.2   59.22  0.9199   0.33890    
>  Residuals                166 10685.9   64.37                      
>  ---
>  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
>  
>  4 observations deleted due to missingness
```

That's a lot of results to process, so here is a run-down (focusing on main effects):

- All main effects (nocturnality, faunivory, and arboreality) are significant in the MANOVAs for all three subsets of the data.
- All main effects are significant in one-way ANOVAs for the full dataset. 
- After dropping marsupials and anthropoids, there is a mixture of significant main effects in one-way ANOVAs... nocturnality and faunivory were significant predictors of frontition, all three main effects were significant predictors of convergence, and only nocturnality was a significant predictor of verticality.
- After dropping marsupials and all primates, only the main effects for nocturnality and faunivory are significant.

This last finding- that arboreality is non-significant in the one-way ANOVAs when marsupials and all primates are dropped from the analysis- is the key result that Heesy (2008) interprets as support for the Nocturnal Visual Predation hypothesis and against hypotheses that focus on arboreality as a driving factor behind orbit evolution. I find it highly suspect to base this conclusion on a non-significant statistical result, particularly one which only appears after much of the data (and thus statistical power) has been removed. I also think it is noteworthy that the interaction between nocturnality and faunivory was not significant in the final model, since I would *think* that the Nocturnal Visual Predation Hypothesis should predict a significant *interaction* between these variables (not just independent effects). That said, I will now demonstrate that more appropriate phylogenetic models eliminate nearly all of the significant statistical results, rendering moot the interpretation of the particular arrangement of p-values in Heesy's (2008) original results. 

## Problem of phylogenetic autocorrelation

Phylogenetic autocorrelation, also called phylogenetic pseudoreplication or phylogenetic non-independence, is a well-known problem in comparative evolutionary biology. The problem arises when researchers attempt to apply statistical methods that assume independent observations (e.g., linear regression, ANOVA/MANOVA) to evolutionary data that is not statistically independent. For example, a human, a chimpanzee, and a mouse cannot be considered 3 independent entities because a human and a chimpanzee are much more closely related to each other than they are to a mouse, thus they have had less time to evolve independently. Failure to account for phylogenetic autocorrelation in statistical models leads to elevated risk of Type I error, or false positives, because relationships that are driven by phylogenetic patterns may be incorrectly attributed to predictor variables in the model (Martins & Garland 1991). 

In the following section I use functions from the R packages `geiger` and `geomorph` to correct for phylogenetic autocorrelation in Heesy's (2008) models, and discuss the impact it has on the results.

## Reanalysis of Heesy (2008) with phylogeny

If you want to follow along with the rest of my analysis, install the following R packages (see [info on installing `geomorph`](https://github.com/geomorphR/geomorph/wiki/Installing-geomorph)): 


```r
# install packages
install.packages("ape")
install.packages("geiger")
install.packages("geomorph")
```

Next, import the phylogeny from GitHub. This is a trimmed down version of the mammal supertree published by [Bininda-Emonds et al. (2007)](http://www.nature.com/nature/journal/v446/n7135/abs/nature05634.html). I already did the work of cleaning of taxa labels and dropping taxa from Heesy's data that were not present in the Bininda-Emonds phylogeny, so taxa labels will match up perfectly between the tree and data. 


```r
# load package
library("ape")

# import phylogenetic tree
tree <- read.nexus("https://raw.githubusercontent.com/rgriff23/Heesy_2008_reanalysis/master/data/HeesyTree.nexus")

# arbitrarily resolve polytomies
tree <- multi2di(tree)
```

We can perform a simple phylogenetic MANOVA using the `aov.phylo` function in the `geiger` package. This function has some limitations: it does not accept a `data` argument, and it only allows one predictor variable at a time. Still, we can use it to look at the MANOVA results for individual predictor variables:


```r
# load package
library("geiger")

# define multidimensional response variable
angles <- data[,c("Convergence","Frontition","Verticality")]

# define univariate predictors (must be factors)
nocturnal <- as.factor(setNames(data$Noccode, row.names(data)))
insectivore <- as.factor(setNames(data$Fauncode, row.names(data)))
arboreal <- as.factor(setNames(data$Arbcode, row.names(data)))

# models
aov.phylo(angles ~ nocturnal, phy=tree)
```

```
>  Multivariate Analysis of Variance Table
>  
>  Response: dat
>             Df  Wilks approx-F num-Df den-Df     Pr(>F) Pr(>F) given phy
>  group       1 0.6222   58.697      3    290 1.1091e-29         0.000999
>  Residuals 292                                                          
>               
>  group     ***
>  Residuals    
>  ---
>  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```
>  Call:
>     manova(dat ~ group)
>  
>  Terms:
>                      group Residuals
>  resp 1            2431.92  83207.57
>  resp 2            6858.48 102631.62
>  resp 3           13954.52  30886.77
>  Deg. of Freedom         1       292
>  
>  Residual standard errors: 16.88068 18.74775 10.28478
>  Estimated effects may be unbalanced
>  2 observations deleted due to missingness
```

```r
aov.phylo(angles ~ insectivore, phy=tree)
```

```
>  Multivariate Analysis of Variance Table
>  
>  Response: dat
>             Df   Wilks approx-F num-Df den-Df     Pr(>F) Pr(>F) given phy
>  group       1 0.90743    9.895      3    291 3.1196e-06           0.5574
>  Residuals 293
```

```
>  Call:
>     manova(dat ~ group)
>  
>  Terms:
>                      group Residuals
>  resp 1            3137.52  82574.85
>  resp 2            9815.18 100131.76
>  resp 3            1488.76  43697.67
>  Deg. of Freedom         1       293
>  
>  Residual standard errors: 16.78766 18.48639 12.21224
>  Estimated effects may be unbalanced
>  1 observation deleted due to missingness
```

```r
aov.phylo(angles ~ arboreal, phy=tree)
```

```
>  Multivariate Analysis of Variance Table
>  
>  Response: dat
>             Df   Wilks approx-F num-Df den-Df     Pr(>F) Pr(>F) given phy
>  group       1 0.75702   30.599      3    286 3.4778e-17           0.1309
>  Residuals 288
```

```
>  Call:
>     manova(dat ~ group)
>  
>  Terms:
>                     group Residuals
>  resp 1          18162.23  62470.75
>  resp 2          11076.96  94938.79
>  resp 3           3086.58  40740.90
>  Deg. of Freedom        1       288
>  
>  Residual standard errors: 14.72794 18.15623 11.89376
>  Estimated effects may be unbalanced
>  6 observations deleted due to missingness
```

The output provides both standard (non-phylogenetic) and phylogenetic p-values in the last two columns of the MANOVA table. We can see that all of the standard p-values are highly significant, while the phylogenetic p-values are are much larger. Only nocturnality is significant after controlling for phylogeny.

It would be better to fit models that estimate the effects of all three predictor variables simultaneously (as in Heesy's MANOVAs). The `procD.pgls` function in the `geomorph` package allows us to perform [phylogenetic regression with a multivariate response variable](http://onlinelibrary.wiley.com/doi/10.1111/evo.12463/full) and multiple predictor variables. The function does not handle missing data, so we have to do some pre-processing before fitting the model. The model takes a few moments to run:


```r
# load package
library("geomorph")

# subset data (no missing values allowed)
data.cc <- data[,c("Convergence","Frontition","Verticality","Noccode","Fauncode","Arbcode","GROUP","ORDER")]
data.cc <- data.cc[complete.cases(data.cc),]
angles2 <- data.cc[,1:3]
vars <- data.cc[,4:6]
droptax <- row.names(data)[!(row.names(data) %in% row.names(data.cc))]
tree2 <- multi2di(drop.tip(tree, droptax))

# create new 'geomorph data frame' with response, predictors, and tree
df <- geomorph.data.frame(angles2, vars, tree2)

# multivariate MANOVA with procD.pgls in geomorph
procD.pgls(angles2 ~ Noccode * Fauncode * Arbcode, phy=tree2, data=df, print.progress=F)
```

```
>  
>  Call:
>  procD.pgls(f1 = angles2 ~ Noccode * Fauncode * Arbcode, phy = tree2,  
>      data = df, print.progress = F) 
>  
>  
>  
>  Type I (Sequential) Sums of Squares and Cross-products
>  Randomized Residual Permutation Procedure Used
>  1000 Permutations
>  
>                            Df      SS      MS       Rsq      F       Z
>  Noccode                    1   18.82 18.8184 0.0084944 2.4288 0.54575
>  Fauncode                   1    0.76  0.7620 0.0003439 0.0983 0.02918
>  Arbcode                    1    9.81  9.8081 0.0044272 1.2659 0.95895
>  Noccode:Fauncode           1    0.81  0.8068 0.0003642 0.1041 0.06241
>  Noccode:Arbcode            1    4.12  4.1157 0.0018578 0.5312 0.40842
>  Fauncode:Arbcode           1    2.12  2.1159 0.0009551 0.2731 0.21054
>  Noccode:Fauncode:Arbcode   1    1.76  1.7566 0.0007929 0.2267 0.17210
>  Residuals                281 2177.21  7.7481                         
>  Total                    288 2215.39                                 
>                           Pr(>F)
>  Noccode                   0.420
>  Fauncode                  0.978
>  Arbcode                   0.235
>  Noccode:Fauncode          0.941
>  Noccode:Arbcode           0.539
>  Fauncode:Arbcode          0.757
>  Noccode:Fauncode:Arbcode  0.792
>  Residuals                      
>  Total
```

Nothing is significant!

It is worth fitting these models to subsets of the data if we are concerned that certain groups of mammals (e.g., marsupials and anthropoids/primates) are not subject to the same evolutionary 'rules' as the other groups. More complex models could actually try to *model* these differences, but my goal here is simply to replicate Heesy (2008) with the addition of a phylogeny, so we'll fit the MANOVAs using the same subsets of the data as Heesy (2008):


```r
# drop marsupials and anthropoids, then rerun phylogenetic MANOVA
data.cc.eu1 <- data.cc[!(data.cc$ORDER%in%c("Didelphimorphia","Diprotodontia")),]
data.cc.eu1 <- data.cc.eu1[data.cc.eu1$GROUP != "Anthropoidea",]
angles3 <- data.cc.eu1[,1:3]
vars3 <- data.cc.eu1[,4:6]
tree3 <- drop.tip(tree2, setdiff(tree2$tip.label,row.names(data.cc.eu1)))
df3 <- geomorph.data.frame(angles3, vars3, tree3)
procD.pgls(angles3 ~ Noccode * Fauncode * Arbcode, phy=tree3, data=df3, print.progress=F)
```

```
>  
>  Call:
>  procD.pgls(f1 = angles3 ~ Noccode * Fauncode * Arbcode, phy = tree3,  
>      data = df3, print.progress = F) 
>  
>  
>  
>  Type I (Sequential) Sums of Squares and Cross-products
>  Randomized Residual Permutation Procedure Used
>  1000 Permutations
>  
>                            Df      SS      MS       Rsq      F       Z
>  Noccode                    1   27.70 27.6995 0.0179847 3.7741 0.93823
>  Fauncode                   1    0.46  0.4588 0.0002979 0.0625 0.01914
>  Arbcode                    1    9.26  9.2595 0.0060120 1.2616 1.00097
>  Noccode:Fauncode           1    3.49  3.4867 0.0022638 0.4751 0.27845
>  Noccode:Arbcode            1    1.25  1.2540 0.0008142 0.1709 0.12721
>  Fauncode:Arbcode           1    0.40  0.4005 0.0002600 0.0546 0.03804
>  Noccode:Fauncode:Arbcode   1    7.72  7.7250 0.0050157 1.0525 0.76869
>  Residuals                203 1489.88  7.3393                         
>  Total                    210 1540.17                                 
>                           Pr(>F)
>  Noccode                   0.261
>  Fauncode                  0.988
>  Arbcode                   0.237
>  Noccode:Fauncode          0.664
>  Noccode:Arbcode           0.833
>  Fauncode:Arbcode          0.968
>  Noccode:Fauncode:Arbcode  0.322
>  Residuals                      
>  Total
```

```r
# drop marsupials and primates, then rerun phylogenetic MANOVA
data.cc.eu2 <- data.cc.eu1[data.cc.eu1$ORDER != "Primates",]
angles4 <- data.cc.eu2[,1:3]
vars4 <- data.cc.eu2[,4:6]
tree4 <- drop.tip(tree3, setdiff(tree3$tip.label,row.names(data.cc.eu2)))
df4 <- geomorph.data.frame(angles4, vars4, tree4)
procD.pgls(angles4 ~ Noccode * Fauncode * Arbcode, phy=tree4, data=df4, print.progress=F)
```

```
>  
>  Call:
>  procD.pgls(f1 = angles4 ~ Noccode * Fauncode * Arbcode, phy = tree4,  
>      data = df4, print.progress = F) 
>  
>  
>  
>  Type I (Sequential) Sums of Squares and Cross-products
>  Randomized Residual Permutation Procedure Used
>  1000 Permutations
>  
>                            Df      SS     MS       Rsq      F       Z
>  Noccode                    1   33.24 33.238 0.0236845 4.1180 1.01256
>  Fauncode                   1    0.20  0.201 0.0001429 0.0248 0.00751
>  Arbcode                    1   10.88 10.885 0.0077561 1.3486 1.10420
>  Noccode:Fauncode           1    9.17  9.172 0.0065358 1.1364 0.71120
>  Noccode:Arbcode            1    5.35  5.346 0.0038095 0.6624 0.45790
>  Fauncode:Arbcode           1    0.71  0.715 0.0005094 0.0886 0.07315
>  Noccode:Fauncode:Arbcode   1    3.97  3.967 0.0028267 0.4915 0.40791
>  Residuals                166 1339.85  8.071                         
>  Total                    173 1403.38                                
>                           Pr(>F)
>  Noccode                   0.214
>  Fauncode                  0.998
>  Arbcode                   0.191
>  Noccode:Fauncode          0.347
>  Noccode:Arbcode           0.512
>  Fauncode:Arbcode          0.914
>  Noccode:Fauncode:Arbcode  0.565
>  Residuals                      
>  Total
```

Again, nothing is significant! Simply incorporating phylogeny into the analysis has transformed a study for which nearly every statistical test yielded a significant result into a study with NO significant results. This shows how important it can be to include phylogeny in analyses of interspecific data.

## Concluding remarks

It is important to keep in mind what 'negative' or 'null' results such as these do *not* tell us. Specifically, the fact that there are no significant relationships between the ecological variables and orbit orientation does *not* imply that evolutionary shifts in orbit orientation were *not* driven by the ecological variables in question. It could be that any or all of these variables played a role in directing the evolution of early primate orbits. However, unless our data captures numerous instances of correlated shifts in orbit orientation and ecology, we are unlikely to find statistical associations between these variables after controlling for phylogenetic autocorrelation. Inferences about such singular or very rare events in evolutionary history may have to depend more on circumstantial rather than statistical evidence. 

I see at least two major directions for future phylogenetic comparative work on the evolution of orbit orientation. 

- First is expanding and refining the dataset. There is room for more complete sampling of extant taxa. It also would be good to include other aspects of skull morphology in the models, such as the size and shape of the [braincase and basicranium](http://onlinelibrary.wiley.com/doi/10.1002/ajpa.1330910306/full), perhaps in a [geometric morphometrics framework](https://en.wikipedia.org/wiki/Geometric_morphometrics_in_anthropology). Additionally, the ecological variables could use some work. Although activity pattern is relatively straightforward to code as a discrete variable, diet and substrate use are much more fraught, and predictor variables should be selected to reflect the hypotheses being tested as directly as possible. For example, if "leaping" is a factor that is thought to select for convergent orbits, then "leaping" is a much better predictor variable than "arboreality", which includes things like lorises and sloths that creep slowly along branches. Similarly, if "visual predation"" is a factor thought to select for convergent orbits, then "visual predation" is a much better predictor variable than "faunivory", which includes things like aye-ayes that find their prey by tapping on trees like woodpeckers. 

- Second is fitting more sophisticated models that aim to detect shifts in the tempo or mode of evolution (e.g., like [this](http://onlinelibrary.wiley.com/doi/10.1111/2041-210X.12084/full)). This is a rather different approach that aims to identify parts of a phylogeny where the rules of evolution seem to change. For instance, it would be interesting to know if there is a statistically significant 'shift' in the mean orbit orientation at the base of the primate clade. That wouldn't tell us *why* the shift occurred, but it would at least support our assumption that *something* happened there that warrants explanation. I think the Nocturnal Visual Predation hypothesis would predict a mean shift at the base of both the primates and the carnivores, as the ancestors of both groups are thought to have been nocturnal visual predators. 

These directions are complementary, since adding more data ([particularly fossils](http://onlinelibrary.wiley.com/doi/10.1111/2041-210X.12285/full)) increases statistical power to detect deviations from Brownian evolution.

**References**:

* Bininda-Emonds, O.R., Cardillo, M., Jones, K.E., MacPhee, R.D., Beck, R.M., Grenyer, R., Price, S.A., Vos, R.A., Gittleman, J.L. and Purvis, A., 2007. The delayed rise of present-day mammals. *Nature* 446: 507-512.

* Cartmill, M. 1992. New views on primate origins. *Evolutionary Anthropology* 1(3):105-11.

* Heesy, C.P., 2008. Ecomorphology of orbit orientation and the adaptive significance of binocular vision in primates and other mammals. *Brain, Behavior and Evolution* 71:54-67.

* Martins, E.P., and T. Garland. 1991. Phylogenetic analyses of the correlated evolution of continuous character: a simulation study. *Evolution* 45:534-57.

* Rasmussen. D.T. 1990. Primate origins: lessons from a neotropical marsupial. *American Journal of Primatology* 22:263-77.

* Sussman, R.W. 1991. Primate origins and the evolution of angiosperms. *American Journal of Primatology* 23:209-223.

* Szalay, F.S., and M. Dagosto. 1980. Locomotor adaptations as reflected on the humerus of Paleogene primates. *Folia Primatologica* 34:1-45.
