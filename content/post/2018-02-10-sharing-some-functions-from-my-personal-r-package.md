---
title: Sharing some functions from my personal R package
author: Daniel Anderson
date: '2018-02-10'
slug: sharing-some-functions-from-my-personal-r-package
categories: [R Code, R Packages]
tags:
  - sundry
  - Data Manipulations
output: 
  html_document:
    keep_md: true
---




In this post I basically just wanted to share some recent developments that I've made to my personal R package [{sundry}](https://github.com/DJAnderson07/sundry). All of the recent advancements have been made to work with the tidyverse, so things like `group_by` should work seamlessly. If you feel like giving the package a whirl, I'd love any feedback you have or bugs you may find. At this point the package is only on github. If there seems to be interest from others in using any of this functionality, I may submit it to CRAN. You can install it with `devtools::install_github("DJAnderson_07/sundry")`

## Batch reading data
Probably my favorite new function is `read_files`, which is basically meant to make batch reading in files easy. It uses `purrr::map_df` by default, so all the data frames are bound into a single data frame. And, the part I think is really neat, is that it leverages the power of the [{rio}](https://github.com/leeper/rio) package so you don't really have to worry much about file types. In fact, the files you read in can all be of different types and it's no big deal. Here's an example, from the README. 

First, we'll load the tidyverse and sundry, then split the iris dataset by species.


```r
library(sundry)
library(tidyverse)
by_species <- iris %>%
  split(.$Species) %>%
  map(select, -Species)

str(by_species)
```

```r
## List of 3
##  $ setosa    :'data.frame':	50 obs. of  4 variables:
##   ..$ Sepal.Length: num [1:50] 5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
##   ..$ Sepal.Width : num [1:50] 3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
##   ..$ Petal.Length: num [1:50] 1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
##   ..$ Petal.Width : num [1:50] 0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
##  $ versicolor:'data.frame':	50 obs. of  4 variables:
##   ..$ Sepal.Length: num [1:50] 7 6.4 6.9 5.5 6.5 5.7 6.3 4.9 6.6 5.2 ...
##   ..$ Sepal.Width : num [1:50] 3.2 3.2 3.1 2.3 2.8 2.8 3.3 2.4 2.9 2.7 ...
##   ..$ Petal.Length: num [1:50] 4.7 4.5 4.9 4 4.6 4.5 4.7 3.3 4.6 3.9 ...
##   ..$ Petal.Width : num [1:50] 1.4 1.5 1.5 1.3 1.5 1.3 1.6 1 1.3 1.4 ...
##  $ virginica :'data.frame':	50 obs. of  4 variables:
##   ..$ Sepal.Length: num [1:50] 6.3 5.8 7.1 6.3 6.5 7.6 4.9 7.3 6.7 7.2 ...
##   ..$ Sepal.Width : num [1:50] 3.3 2.7 3 2.9 3 3 2.5 2.9 2.5 3.6 ...
##   ..$ Petal.Length: num [1:50] 6 5.1 5.9 5.6 5.8 6.6 4.5 6.3 5.8 6.1 ...
##   ..$ Petal.Width : num [1:50] 2.5 1.9 2.1 1.8 2.2 2.1 1.7 1.8 1.8 2.5 ...
```

Next, we'll export each dataset from the split as different file types. Note that for each dataset, I'm not only writing the file out in a different format (csv, EXCEL, and SPSS), but I'm also only writing out specific columns (which are not all in common). So these are all fairly different files at this point, but we can imagine them all being part of the same study.


```r
rio::export(by_species$setosa[ ,1:2], "setosa.csv")
rio::export(by_species$versicolor[ ,2:4], "versicolor.xlsx")
rio::export(by_species$virginica[ ,2:3], "virginica.sav")
```

Now, we can import all of these datasets back into R with the `sundry::read_files` function.


```r
d <- read_files()
d
```

```r
## # A tibble: 150 x 5
##    file   Sepal.Length Sepal.Width Petal.Length Petal.Width
##    <chr>         <dbl>       <dbl>        <dbl>       <dbl>
##  1 setosa         5.10        3.50           NA          NA
##  2 setosa         4.90        3.00           NA          NA
##  3 setosa         4.70        3.20           NA          NA
##  4 setosa         4.60        3.10           NA          NA
##  5 setosa         5.00        3.60           NA          NA
##  6 setosa         5.40        3.90           NA          NA
##  7 setosa         4.60        3.40           NA          NA
##  8 setosa         5.00        3.40           NA          NA
##  9 setosa         4.40        2.90           NA          NA
## 10 setosa         4.90        3.10           NA          NA
## # ... with 140 more rows
```

```r
d %>% 
  count(file)
```

```r
## # A tibble: 3 x 2
##   file           n
##   <chr>      <int>
## 1 setosa        50
## 2 versicolor    50
## 3 virginica     50
```

This can be a little tricky though, because sometimes you might have the same file in multiple formats, or you may want to only read in data some datasets from a directory but not all. That's where the optional `pat` argument comes in. For example, let's write out one additional csv file, and then read in only the csv files.


```r
rio::export(by_species$virginica[ ,2:3], "virginica.csv")
d2 <- read_files(pat = "csv")
head(d2)
```

```r
## # A tibble: 6 x 4
##   file   Sepal.Length Sepal.Width Petal.Length
##   <chr>         <dbl>       <dbl>        <dbl>
## 1 setosa         5.10        3.50           NA
## 2 setosa         4.90        3.00           NA
## 3 setosa         4.70        3.20           NA
## 4 setosa         4.60        3.10           NA
## 5 setosa         5.00        3.60           NA
## 6 setosa         5.40        3.90           NA
```

```r
tail(d2)
```

```r
## # A tibble: 6 x 4
##   file      Sepal.Length Sepal.Width Petal.Length
##   <chr>            <dbl>       <dbl>        <dbl>
## 1 virginica           NA        3.30         5.70
## 2 virginica           NA        3.00         5.20
## 3 virginica           NA        2.50         5.00
## 4 virginica           NA        3.00         5.20
## 5 virginica           NA        3.40         5.40
## 6 virginica           NA        3.00         5.10
```

Finally, we'll clean up a bit by deleting all the files we wrote out for this example


```r
fs::file_delete(c("setosa.csv", "versicolor.xlsx", 
                  "virginica.sav", "virginica.csv"))
```

## Quick descriptive statistics
I'm sure there are other packages that do similar things, but I often find myself just needing quick descriptives for a variable. That's where `sundry::descrips` comes in helpful. It's relatively straightforward. You just supply the columns you want descriptive statistics on and, by default, it returns the number of cases, min and max values, as well as the mean and standard deviation.


```r
storms %>% 
  descrips(wind, pressure)
```

```r
## # A tibble: 2 x 6
##   variable     n   min   max  mean    sd
##   <chr>    <dbl> <dbl> <dbl> <dbl> <dbl>
## 1 pressure 10010 882    1022 992    19.5
## 2 wind     10010  10.0   160  53.5  26.2
```

The function also works well with `dplyr::group_by`


```r
storms %>% 
  group_by(year) %>% 
  descrips(wind, pressure)
```

```r
## # A tibble: 82 x 7
##     year variable     n   min    max   mean    sd
##    <dbl> <chr>    <dbl> <dbl>  <dbl>  <dbl> <dbl>
##  1  1975 pressure  86.0 963   1014    995   15.2 
##  2  1975 wind      86.0  20.0  100     50.9 23.6 
##  3  1976 pressure  52.0 957   1012    989   15.3 
##  4  1976 wind      52.0  20.0  105     59.9 24.8 
##  5  1977 pressure  53.0 926   1015    995   20.4 
##  6  1977 wind      53.0  20.0  150     54.0 29.6 
##  7  1978 pressure  54.0 980   1012   1006    6.64
##  8  1978 wind      54.0  20.0   80.0   40.5 13.9 
##  9  1979 pressure 301   924   1014    995   19.9 
## 10  1979 wind     301    15.0  150     48.7 30.3 
## # ... with 72 more rows
```

And finally, if you want different functions, you can supply them via the optional `.funs` argument. Below, we'll calculate the 25th, 50th, and 75th percentiles instead.


```r
storms %>% 
  group_by(year) %>% 
  descrips(wind, pressure,
           .funs = funs(qtile25 = quantile(., 0.25),
                        median, 
                        qtile75 = quantile(., 0.75)))
```

```r
## # A tibble: 82 x 5
##     year variable qtile25 median qtile75
##    <dbl> <chr>      <dbl>  <dbl>   <dbl>
##  1  1975 pressure   984    997    1011  
##  2  1975 wind        25.0   52.5    65.0
##  3  1976 pressure   978    992    1000  
##  4  1976 wind        38.8   60.0    80.0
##  5  1977 pressure   994   1001    1010  
##  6  1977 wind        30.0   45.0    70.0
##  7  1978 pressure  1006   1007    1009  
##  8  1978 wind        30.0   40.0    45.0
##  9  1979 pressure   988   1002    1008  
## 10  1979 wind        25.0   35.0    65.0
## # ... with 72 more rows
```

## Remove rows with complete missing data across a set of variables
In many datasets I work with, there are sets of variables that have complete missing data. I want to remove any rows that are missing acrross all of these variables. This is different from `janitor::remove_empty_rows`, because these rows may have valid data on other variables, just not across the set of variables I'm interested in. Below is an example from the Oregon Department of Education on schools, where the number and percent of students scoring in each statewide proficiency category on the statewide test are missing if the *n* size is too small (for confidentiality purposes).


```r
d <- rio::import("http://www.oregon.gov/ode/educator-resources/assessment/TestResults2017/pagr_schools_ela_tot_ecd_ext_gnd_lep_1617.xlsx",
            setclass = "tbl_df",
            na = c("--", "*")) %>% 
  janitor::clean_names()

d %>% 
  select(district_id, number_level_4:percent_level_1)
```

```r
## # A tibble: 23,760 x 9
##    district_id number_level_4 percent_level_4 number_level_3
##          <dbl> <chr>          <chr>           <chr>         
##  1        2063 <NA>           <NA>            <NA>          
##  2        2063 <NA>           <NA>            <NA>          
##  3        2063 <NA>           <NA>            <NA>          
##  4        2063 <NA>           <NA>            <NA>          
##  5        2063 <NA>           <NA>            <NA>          
##  6        2063 <NA>           <NA>            <NA>          
##  7        2063 <NA>           <NA>            <NA>          
##  8        2063 <NA>           <NA>            <NA>          
##  9        2063 <NA>           <NA>            <NA>          
## 10        2063 <NA>           <NA>            <NA>          
## # ... with 23,750 more rows, and 5 more variables: percent_level_3 <chr>,
## #   number_level_2 <chr>, percent_level_2 <chr>, number_level_1 <chr>,
## #   percent_level_1 <chr>
```

Note that there are many more columns here, but I'm only showing the ones that I'm interested in. I want to remove and rows that are missing across these variables, which I can do with `sundry::rm_empty_rows`.


```r
d %>% 
  rm_empty_rows(number_level_4:percent_level_1) %>% 
  select(district_id, number_level_4:percent_level_1) 
```

```r
## # A tibble: 15,081 x 9
##    district_id number_level_4 percent_level_4    number_level_3
##          <dbl> <chr>          <chr>              <chr>         
##  1        2113 5              45.5               5             
##  2        2113 5              29.4               8             
##  3        2113 2              20                 5             
##  4        2113 5              33.299999999999997 7             
##  5        2113 2              20                 5             
##  6        2113 0              0                  6             
##  7        2113 7              53.8               5             
##  8        2113 5              41.7               4             
##  9        2113 5              41.7               6             
## 10        2113 -              -                  -             
## # ... with 15,071 more rows, and 5 more variables: percent_level_3 <chr>,
## #   number_level_2 <chr>, percent_level_2 <chr>, number_level_1 <chr>,
## #   percent_level_1 <chr>
```

In the above, rows with partial missing data across the set of columns are still returned. The function can also be provided without any column arguments, and the function will then mimic the behavior or `janitor::remove_empty_rows`. 

## Filter by functions
For plotting purposes, in particular, I often find myself needing to filter a dataset according to values that can be obtained from functions, such as the min and the max. Below is an example, where the dataset is filtered to return only the rows where the wind speed is equal to the minimum or the maximum wind speed.


```r
storms %>%
  filter_by_funs(wind, funs(min, max)) %>% 
  select(fun, name, year, wind) 
```

```r
## # A tibble: 11 x 4
##    fun   name      year  wind
##    <chr> <chr>    <dbl> <int>
##  1 min   Bonnie    1986    10
##  2 min   Bonnie    1986    10
##  3 min   AL031987  1987    10
##  4 min   AL031987  1987    10
##  5 min   AL031987  1987    10
##  6 min   Alberto   1994    10
##  7 min   Alberto   1994    10
##  8 min   Alberto   1994    10
##  9 min   Alberto   1994    10
## 10 max   Gilbert   1988   160
## 11 max   Wilma     2005   160
```

So in this case, the minimum wind speed is 10, and the maximum is 160. The first 9 rows all match the minimum wind speed, while the 10th and 11th rows match the max. You can quickly identify which function the row was selected on by the *fun* column that is added to the data frame. Again, this function works well with `dplyr::group_by`, and should work with any function.


```r
storms %>%
  group_by(year) %>% 
  filter_by_funs(wind, funs(min, max)) %>% 
  select(fun, name, year, wind) %>% 
  arrange(year)
```

```r
## # A tibble: 387 x 4
## # Groups:   year [41]
##    fun   name      year  wind
##    <chr> <chr>    <dbl> <int>
##  1 min   Caroline  1975    20
##  2 min   Caroline  1975    20
##  3 max   Caroline  1975   100
##  4 max   Caroline  1975   100
##  5 min   Gloria    1976    20
##  6 min   Gloria    1976    20
##  7 max   Belle     1976   105
##  8 max   Belle     1976   105
##  9 min   Anita     1977    20
## 10 min   Clara     1977    20
## # ... with 377 more rows
```

## Conclusions
There are a few other functions in the package that might be helfpul, but I didn't want this post to get too long. I would love any feedback!
