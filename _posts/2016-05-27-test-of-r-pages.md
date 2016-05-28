---
layout: post
title: "test of R pages"
description: ""
category: 
tags: []
---




## R Markdown

This is an R Markdown presentation. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document.

## Slide with Bullets

- Bullet 1
- Bullet 2
- Bullet 3

## Slide with R Output


{% highlight r %}
summary(cars)
{% endhighlight %}

{% highlight text %}
##      speed           dist       
##  Min.   : 4.0   Min.   :  2.00  
##  1st Qu.:12.0   1st Qu.: 26.00  
##  Median :15.0   Median : 36.00  
##  Mean   :15.4   Mean   : 42.98  
##  3rd Qu.:19.0   3rd Qu.: 56.00  
##  Max.   :25.0   Max.   :120.00
{% endhighlight %}

{% highlight r %}
names(formals(servr::jekyll))  # arguments of the jekyll() function
{% endhighlight %}



{% highlight text %}
## [1] "dir"     "input"   "output"  "script"  "serve"   "command"
## [7] "..."
{% endhighlight %}



## Slide with Plot

{% highlight r %}
plot(pressure)
{% endhighlight %}


![plot of chunk pressure](http://winterwang.github.io/assets/pressure-1.png)


## Generate a table
{% highlight r %}
# generate a table
knitr::kable(head(mtcars))
{% endhighlight %}



|                  |  mpg| cyl| disp|  hp| drat|   wt| qsec| vs| am| gear| carb|
|:-----------------|----:|---:|----:|---:|----:|----:|----:|--:|--:|----:|----:|
|Mazda RX4         | 21.0|   6|  160| 110| 3.90| 2.62| 16.5|  0|  1|    4|    4|
|Mazda RX4 Wag     | 21.0|   6|  160| 110| 3.90| 2.88| 17.0|  0|  1|    4|    4|
|Datsun 710        | 22.8|   4|  108|  93| 3.85| 2.32| 18.6|  1|  1|    4|    1|
|Hornet 4 Drive    | 21.4|   6|  258| 110| 3.08| 3.21| 19.4|  1|  0|    3|    1|
|Hornet Sportabout | 18.7|   8|  360| 175| 3.15| 3.44| 17.0|  0|  0|    3|    2|
|Valiant           | 18.1|   6|  225| 105| 2.76| 3.46| 20.2|  1|  0|    3|    1|
