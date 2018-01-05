---
title: esvis
comments: false
---

{{< figure class="image main" src="/img/pp_plot_frl.png" >}}

The esvis package is designed to visually compare two or more distributions across the entirety of the scale, rather than only by measures of central tendency (e.g., means). There are also some functions for estimating effect size, including Cohen's *d*, Hedges' *g*, percentage above a cut, transformed (normalized) percentage above a cut, the area under the curve (conceptually equivalent to the probability that a randomly selected individual from Distribution A has a higher value than a randomly selected individual from Distribution B), and the *V* statistic, which essentially transforms the area under the curve to standard deviation units (see [Ho, 2009](https://www.jstor.org/stable/40263526?seq=1#page_scan_tab_contents)).

# Installation
------------

Install directly from CRAN with

``` r
install.packages("esvis")
```

Or the development version from from github with:

``` r
# install.packages("devtools")
devtools::install_github("DJAnderson07/esvis")
```
------------

# Blog Posts
* [Introduction to esvis](../../post/esvis-part-1)
* [Binned Effect Size Plots](../../post/esvis-binned-effect-size-plots)
