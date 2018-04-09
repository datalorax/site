---
title: A tidyeval use case
author: Daniel Anderson
date: '2018-01-09'
slug: a-tidyeval-use-case
categories: [R Code]
output: 
  html_document:
    keep_md: true
tags:
  - tidyeval
  - Data Manipulations
  - Custom Functions
---



A relatively routine process for me is to combine multiple files into a single data frame by row. For example, the data might be stored in separate CSV files by grade and content area, but I want to load them all and treat it as a single data frame with a grade and content indicator. A good default for this sort of process, is to keep all the variables that are present in any data file, and pad with missingness for the files that don't have that specific variable. This is the default for `dplyr::bind_rows`. For example,


```r
library(tidyverse)
d1 <- data_frame(a = 1:5, b = letters[1:5])
d2 <- data_frame(a = 1:5, z = rnorm(5))
bind_rows(d1, d2)
```

```r
## # A tibble: 10 x 3
##        a b           z
##    <int> <chr>   <dbl>
##  1     1 a      NA    
##  2     2 b      NA    
##  3     3 c      NA    
##  4     4 d      NA    
##  5     5 e      NA    
##  6     1 <NA>    0.789
##  7     2 <NA>    0.757
##  8     3 <NA>  - 0.298
##  9     4 <NA>  - 0.226
## 10     5 <NA>    0.705
```

Recently, however, I had a student ask me if there was a function that would *only* keep columns that were common across all the datasets. I didn't know of any such function, and couldn't find any arguments to pass to `dplyr::bind_rows` to change the default behavior (if you do, please let me know). So we decided to write a function. My initial inclination was to use base syntax, and I was actually pretty happy with the solution, which was


```r
bind_rows_drop <- function(l) {
  common <- Reduce(intersect, lapply(l, names))
  new <- lapply(l, "[", common)
  do.call(rbind, new)
}
```
Basically, a list (`l`) of data frames is fed to the function. The names of the columns are then extracted, via `lapply`, and only those in common across all datasets are returned by looping the `intersect` function through the list of names with the `Reduce` function. Then, we just subset each dataset to only the columns that are common, and bind all the rows together with a combination of `do.call` and `rbind`. In the above example, this function returns only column a


```r
bind_rows_drop(list(d1, d2))
```

```r
## # A tibble: 10 x 1
##        a
##    <int>
##  1     1
##  2     2
##  3     3
##  4     4
##  5     5
##  6     1
##  7     2
##  8     3
##  9     4
## 10     5
```

As I said, I was pretty satisfied with this solution, but [the course I teach](http://www.dandersondata.com/page/classr/classr/) is focused on the tidyverse and so I thought it might be a good idea to try to replicate the function using the tidyverse suite of tools, given that the student was already familiar with most of those functions. I wanted the proces to basically be the same, but using all tidyverse functions. My first attempt looked like this:


```r
tidy_bind_drop <- function(l) {
  common <- reduce(map(l, names), intersect)
  new <- map(l, `[`, common)

  bind_rows(new, .id = "dataset")
}
```

This appears to work. For example


```r
tidy_bind_drop(list(d1, d2))
```

```r
## # A tibble: 10 x 2
##    dataset     a
##    <chr>   <int>
##  1 1           1
##  2 1           2
##  3 1           3
##  4 1           4
##  5 1           5
##  6 2           1
##  7 2           2
##  8 2           3
##  9 2           4
## 10 2           5
```
One of the nice parts of this function is we get the dataset identifier easily (of course, we could have built something like this in to our first function). But unfortunately, this only works if the the variable types are the same across all datasets. For example the following fails:


```r
d3 <- data_frame(a = factor(11:15), z = rnorm(5))
tidy_bind_drop(list(d1, d3))
```

```r
## Error in bind_rows_(x, .id): Column `a` can't be converted from integer to factor
```
This is because the `bind_rows` function requires all columns be the same type, or coercible according to a set of rules (see [here](https://github.com/hadley/vctrs/issues/7)). There's plenty of ways to handle this, but rather than doing something like automatically coercing all non-equivalent types to character prior to binding the rows, I wanted to make it an explicit argument. The error message tells you which variable has the issue, so if you make it explicit, then you force the user (usually me, or in this case my student) to state which variables will be coerced so there's no surprises. 

Here's where *tidyeval* came in. My idea was that the name of the variable(s) could be supplied following the list, and they would be coerced to character. Because I (or the user) would not neccessarily know beforehand how many variables would need to be coerced prior to binding, I had to build in the argument with `...`. Whatever variable names were supplied were then passed to `dplyr::mutate_at` and looped through the list of data frames. The end result looked like this


```r
tidy_bind_drop <- function(l, ...) {
  common <- reduce(map(l, names), intersect)
  new <- map(l, `[`, common)
  
  convert <- quos(...) # quote the variables to convert
  new <- map(new, ~mutate_at(., vars(!!!convert), # bang, bang, bang to unquote
                                    as.character))
  
  bind_rows(new, .id = "dataset")
}
```
which looks very similar to before, but now has the convert portion. To capture the variables to be converted, we first have to quote the input, through `quos`. We then unquote it when we pass it to dplyr functions to let the function know we've already done the quoting for it, so it doesn't need to. See [here](http://dplyr.tidyverse.org/articles/programming.html) for more information.

Now, the function works as we'd hope, provided we supply the additional argument of the column to be coerced.


```r
tidy_bind_drop(list(d1, d2, d3))
```

```r
## Error in bind_rows_(x, .id): Column `a` can't be converted from integer to factor
```

```r
tidy_bind_drop(list(d1, d2, d3), a)
```

```r
## # A tibble: 15 x 2
##    dataset a    
##    <chr>   <chr>
##  1 1       1    
##  2 1       2    
##  3 1       3    
##  4 1       4    
##  5 1       5    
##  6 2       1    
##  7 2       2    
##  8 2       3    
##  9 2       4    
## 10 2       5    
## 11 3       11   
## 12 3       12   
## 13 3       13   
## 14 3       14   
## 15 3       15
```
This also works if we have more than one column to convert


```r
d4 <- data_frame(a = as.character(6:10), 
                 b = factor(letters[1:5]), 
                 z = as.character(rnorm(5)))
d5 <- data_frame(a = 11:15, z = rnorm(5))
tidy_bind_drop(list(d4, d5), a)  
```

```r
## Error in bind_rows_(x, .id): Column `z` can't be converted from character to numeric
```

```r
tidy_bind_drop(list(d4, d5), a, z)  
```

```r
## # A tibble: 10 x 3
##    dataset a     z                 
##    <chr>   <chr> <chr>             
##  1 1       6     0.644138427843719 
##  2 1       7     -0.230419020062587
##  3 1       8     1.30136253600835  
##  4 1       9     -0.33528012770119 
##  5 1       10    -0.306403319429014
##  6 2       11    0.548567447503353 
##  7 2       12    0.675819960607429 
##  8 2       13    -1.47585262014806 
##  9 2       14    0.168414918173031 
## 10 2       15    0.315916540558179
```
So how is this any better than the base version? The code to produce it is a bit more complicated, and now we have to pass additional arguments to supply. First, I would argue that dplyr is actually being helpful by forcing the decision on the user, rather than implicitly coercing the variables because, unless you are initimately familiar with them, implicit coercion rules can produce some surprising results. But in this case a more tangible benefit is that the tidyverse version is *much* faster. Let's simulate a couple really large data frames to test it out.


```r
d_test1 <- data_frame(a = seq_len(1e7), 
                      b = rep(letters[1:5], 1e7/5), 
                      c = factor(rep(letters[5:1], 1e7/5)), 
                      d = rnorm(1e7))

d_test2 <- data_frame(b = factor(rep(letters[1:5], 1e7/5)), 
                      c = rep(letters[5:1], 1e7/5), 
                      d = rnorm(1e7),
                      e = rbinom(1e7, 1, .5))

d_test3 <- data_frame(a = seq_len(1e7), 
                      b = rep(letters[1:5], 1e7/5), 
                      c = factor(rep(letters[5:1], 1e7/5)), 
                      d = rnorm(1e7),
                      f = rep(c("green", "blue"), 1e7/2))

base <- system.time({
  bind_rows_drop(list(d_test1, d_test2, d_test3))
})
base
```

```r
##    user  system elapsed 
##   3.110   0.885   4.036
```

```r
tidy <- system.time({
  tidy_bind_drop(list(d_test1, d_test2, d_test3), b, c)
})
tidy
```

```r
##    user  system elapsed 
##   1.047   0.283   1.334
```
So in this rather contrived (and still not very big) example, the tidy version is 3.03 times faster than the base version. I haven't gone through full testing, but generally the magnitude of the speed gain seems to correspond with the size of the problem, with larger problems corresponding to larger differences in speed.

