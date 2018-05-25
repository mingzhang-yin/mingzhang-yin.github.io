---
title: "Team USA women vs NHL hockey players on Twitter (twitteR)"
layout: post
date: 2017-05-01
tags: R hockey twitteR
comments: true
---



April was a good month for the US Women's Ice Hockey National Team (USWNT). In addition to winning their [7th title in 8 years](https://www.usatoday.com/story/sports/hockey/2017/04/07/uswnht-wins-iihf-world-championships-canada/100197176/) at the IIHF World Championships, they negotiated with USA Hockey [to secure](https://www.nytimes.com/2017/03/28/sports/hockey/usa-hockey-uswnt-boycott.html?_r=0) a \$2000 year-round monthly stipend, increased bonuses, a committee for promoting the growth of women’s ice hockey, and the same travel and insurance accommodations as the men’s team. Previously, players received only [$1000 per month](http://www.espn.com/espnw/voices/article/18908360/time-usa-hockey-wake-support-women-team) from USA Hockey during the 6 months leading up to the Olympics, despite the fact that players were expected to train year-round. The deal was a direct result of the USWNT boycott of the World Championship tournament, and represents a historic victory for women’s sports. 

But some hockey fans just can’t handle it. They lash out in the comment sections of articles, littering them with comments such as these:  

___

![](https://i.imgur.com/cyxWVgb.png)
![](https://i.imgur.com/HkIcD32.png)
![](https://i.imgur.com/CGSjBKV.png)
![](https://i.imgur.com/CyNpCoW.png)
![](https://i.imgur.com/upKuVyH.png)
![](https://i.imgur.com/pFpRqEJ.png)

___

Their arguments boil down to this: the USWNT does not deserve more financial support because they don’t generate enough revenue because people don’t care enough about women’s hockey. They are correct to say that women's hockey does not generate much revenue, but the reasons for this are complex, and there is a chicken and egg problem when it comes to the relationship between monetary input and output. The USWNT recognizes that the women's game requires more exposure and publicity, which is why establishing a committee to promote the women's game was part of their deal with USA Hockey. 

What I want to focus on is the claim that people just don't care about women's hockey. How popular are top female players compared to professional male ice hockey players? To address this question, I turned to Twitter, where the number of followers for Twitter users provides a measure of popularity. I decided to compare the number of Twitter followers for members of the USWNT to NHL players. In addition, I used data on [2016-17 NHL salaries](http://www.hockey-reference.com/friv/current_nhl_salaries.cgi) to estimate the average salary of NHL players at a similar level of popularity as USWNT players. 

Before comparing the USWNT to the NHL, I should point out that only ~38% of NHL players were on Twitter when I collected this data (compared to 100% of the USWNT), and it is a biased sample. Comparing the average salary of NHL players who are on Twitter to those who are not on Twitter reveals that players on Twitter earn about 50% more on average than players who are not on Twitter. Thus, the sample of NHL players on Twitter is biased towards better and probably more popular players. 

Keeping that in mind, let's look at the data (for details on how I compiled the data, see the [GitHub repo](https://github.com/rgriff23/NHL_on_twitter)). The following histogram shows the distribution of Twitter follower counts for the 293 current NHL players who use Twitter, while the red vertical lines represent follower counts for current USWNT players, and the blue vertical line in the middle represents the average for NHL players. 

<img src="/assets/Rfigs/post_2017-05_uswnt_histogram-1.png" title="plot of chunk post_2017-05_uswnt_histogram" alt="plot of chunk post_2017-05_uswnt_histogram" style="display: block; margin: auto;" />

The x-axis is on a log scale to make the distribution easier to visualize. For some perspective, the NHL average corresponds to about 40,800 followers, and the range is ~2500 to ~2.4 million. Over half of the women (14/23) are within the range of NHL players, and one women is well above the NHL average ([Hilary Knight](https://twitter.com/Hilary_Knight?lang=en) with ~68,200 followers).

Now let's look at how NHL salaries are related to popularity. A fitted sigmoidal curve is plotted along with the data below, and for some context, the vertical red line shows where Hilary Knight falls on this graph.

<img src="/assets/Rfigs/post_2017-05_uswnt_model-1.png" title="plot of chunk post_2017-05_uswnt_model" alt="plot of chunk post_2017-05_uswnt_model" style="display: block; margin: auto;" />

We can use the fitted curve to estimate the average salary of NHL players with the same level of popularity as the USWNT players. To avoid the dangers of extrapolating beyond the range of the data, I focus on the 14 USWNT players with follower counts within the NHL range. Here are the estimated salaries- all 7 digit figures:   


```
                    Player Followers Estimated_salary
   1:        Hilary Knight     68142         $3760018
   2:        Amanda Kessel     32501         $2815678
   3:        Meghan Duggan     17535         $2193679
   4:  Monique Lamoureux-M     14217         $2012260
   5:          Kelli Stack     13754         $1984908
   6: Jocelyne Lamoureux-D     13413         $1964394
   7:       Brianna Decker     10820         $1796648
   8:          Megan Bozek      9447         $1697605
   9:          Gigi Marvin      8374         $1613879
  10:       Alex Carpenter      7498         $1540539
  11:        Kacey Bellamy      6460         $1446564
  12:        Kendall Coyne      6280         $1429359
  13:       Nicole Hensley      3754         $1147922
  14:        Lee Stecklein      3021         $1045663
```

I am not suggesting that popularity on Twitter should determine anyone's salary. My point is simply this: if there is any validity to the argument that the USWNT doesn't deserve better because they aren't popular, then the data should show that USWNT players are much less popular than male ice hockey players who are making millions. Clearly, that is far from the case.

As a final thought, it is worth remembering that NHL salaries were not always what they are today. After adjusting for inflation, Gordie Howe earned just ~\$630,000 playing for the Red Wings in 1970, a salary that is barely above the current [minimum wage](http://www.puckreport.com/2009/07/nhl-minimum-wage-maximum-wage-by-year.html) in the NHL. Growing a professional sport takes time and investment. It doesn't happen overnight. Women's sports is increasingly recognized as an [untapped market](http://www.abc.net.au/news/2015-06-23/maasdorp-womens-sport-is-a-seriously-untapped-market/6566244), and I'd say the Twitter data supports that conclusion for women's ice hockey. 

**Footnotes:** 

*Twitter data was compiled mid-April, 2017.*

*Data and R code is on [GitHub](https://github.com/rgriff23/NHL_on_twitter).*
