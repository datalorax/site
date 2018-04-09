---
title: Software
comments: false
---

## [esvis]((https://github.com/DJAnderson07/esvis) )
Anderson, D. (2017). esvis: Visualization and Estimation of Effect Sizes. R package version 0.1.0. [CRAN](https://CRAN.R-project.org/package=esvis.) [GitHub](https://github.com/DJAnderson07/esvis) 

The purpose of *esvis* is primarily to visualize differences in two or more distributions. It is an implementation and extension of ideas discussed by Andrew Ho (see, for example, [here](https://www.jstor.org/stable/40263526?seq=1#page_scan_tab_contents)). Non-parametric methods for  effects sizes are also implemented. For an introduction to the package, see [here](http://www.dandersondata.com/post/esvis-part-1/). The package is under active development.

## [r2Winsteps](https://github.com/DJAnderson07/r2Winsteps)
Anderson, D. (2015). r2Winsteps: A package for interfacing between R and the Rasch modeling software Winsteps. R package version 0.0.0.9000. [GitHub](https://github.com/DJAnderson07/r2Winsteps) 

This was my first ever R package and some of the underlying code is not terribly pretty or efficient, but it works surprisingly well nonetheless. The purpose of the package is to provide an interface between R and the [Rasch modeling](https://en.wikipedia.org/wiki/Rasch_model) software [Winsteps](http://www.winsteps.com/index.htm). The package facilitates batch processing, where a list of data frames are fed to the `batchRunWinsteps` function and the neccessary Winsteps syntax is written to the working directory and sent to Winsteps where the analysis is run. Upon completion the item and person files are imported back into R and the working space is cleaned up, by default (i.e., intermediary files removed). The package also contains some plotting functions for r2Winsteps and batchR2Winsteps objects. The package is not under active development, but gets new features every now and then when I have the time and the need to develop extensions. 

## [sundry](https://github.com/DJAnderson07/sundry)
Anderson, D. (2016). sundry: A sundry of convenience functions. R package version 0.0.0.9000. [GitHub](https://github.com/DJAnderson07/sundry)

The *sundry* package is just a sundry of functions that I find useful when working interactively with R. Many of the functions are unique to things I work with. For example, the `collapse_dems` function collapses inconsistent time-series demographic information to the most common category (or randomly assigns when the categories are equal). The `bind_rows_drop` function binds all rows of a list of data frames while dropping all columns that are not represented in all data frames. It is a personal R package that is unlikely to ever make it to CRAN, but if you find any of the functions helpful, I'd love to hear! 