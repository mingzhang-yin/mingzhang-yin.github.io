---
layout: project
title: "caRds"
author: Randi H. Griffin
comments: true
---


___

This is an R package for producing pretty caRds for special occasions. If you have the devtools package installed, you can install `caRds` from GitHub:


```r
library(devtools)
install_github("rgriff23/caRds")
library(caRds)
```
___

### Thanksgiving

`TurkeyDay` creates a Thanksgiving turkey:


```r
TurkeyDay(from = "Randi", to = "America")
```

<img src="/assets/Rfigs/project_caRds_usturkey-1.png" title="plot of chunk project_caRds_usturkey" alt="plot of chunk project_caRds_usturkey" style="display: block; margin: auto;" />

Wish Canada a happy Canadian Thanksgiving with `canadian = TRUE`:


```r
TurkeyDay(from = "Randi", to = "Canada", canadian = TRUE)
```

<img src="/assets/Rfigs/project_caRds_canturkey-1.png" title="plot of chunk project_caRds_canturkey" alt="plot of chunk project_caRds_canturkey" style="display: block; margin: auto;" />

___

### Christmas

`ChristmasTree` generates a jolly tree with presents underneath:


```r
ChristmasTree(from = "Randi", to = "Chase", numPresents = 10)
```

<img src="/assets/Rfigs/project_caRds_xmastree-1.png" title="plot of chunk project_caRds_xmastree" alt="plot of chunk project_caRds_xmastree" style="display: block; margin: auto;" />

Add tinsel with `tinsel = TRUE`. 


```r
ChristmasTree(from = "Randi", to = "Chase", numPresents = 10, tinsel = TRUE)
```

<img src="/assets/Rfigs/project_caRds_xmastreetins-1.png" title="plot of chunk project_caRds_xmastreetins" alt="plot of chunk project_caRds_xmastreetins" style="display: block; margin: auto;" />
___

### Valentine's Day

`OneThousandHearts` sprinkles 1000 tiny hearts about a larger heart, creating negative heart space where a romantic message can be included. If you use the `to` argument to specify the recipient of your Valentine's Day caRd, a simple message will be generated automatically:


```r
OneThousandHearts(to = "Samara")
```

<img src="/assets/Rfigs/project_caRds_hearts-1.png" title="plot of chunk project_caRds_hearts" alt="plot of chunk project_caRds_hearts" style="display: block; margin: auto;" />

Alternatively, use `lines` to include a personalized message up to 4 lines long:


```r
OneThousandHearts(line1 = "Roses are red", 
  line2 = "Violets are blue", 
  line3 = "If you were a Pokemon", 
  line4 = "I would choose you!")
```

<img src="/assets/Rfigs/project_caRds_heartspoem-1.png" title="plot of chunk project_caRds_heartspoem" alt="plot of chunk project_caRds_heartspoem" style="display: block; margin: auto;" />

___

### Easter

`EasterEgg` lays an egg of any color with a baby chicken inside:


```r
EasterEgg(shell = "skyblue")
```

<img src="/assets/Rfigs/project_caRds_egg-1.png" title="plot of chunk project_caRds_egg" alt="plot of chunk project_caRds_egg" style="display: block; margin: auto;" />
___
