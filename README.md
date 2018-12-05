# qckitfastq: A comprehensive quality control R package for Next Generation Sequencing FASTQ data

[![Travis](https://img.shields.io/travis/compbiocore/qckitfastq.svg?style=flat-square)](https://travis-ci.org/compbiocore/qckitfastq) [![coverage](https://img.shields.io/codecov/c/github/compbiocore/qckitfastq.svg?style=flat-square)](https://codecov.io/gh/compbiocore/qckitfastq) [![Docs](https://img.shields.io/badge/docs-stable-steelblue.svg?style=flat-square)](https://compbiocore.github.io/qckitfastq)

# Overview

This R package contains tools for comprehensive quality control of FASTQ format data. We hope to replicate existing tools for FASTQ quality control as well as advance FASTQ metrics where data is truncated for the analysis. We enable efficient processing of FASTQ format data by implementing efficient C++ functions using `Rcpp`. 

The metrics that `qckitfastq` provides are as following:
1. data dimension
2. per base sequence content
3. per base quality score statisitcs
4. per read GC content
5. per read mean quality score
6. overrepresented sequence
7. per base kmer count
8. overrepresented kmer

The above metrices include both analysis results tables and visualizations of results.

# Getting started

## Prerequisites

`qckitfastq` has dependencies on both CRAN packages and Bioconductor packages. Commands to install all prerequisites from R are given below:
```r
install.packages(c('magrittr','ggplot2','dplyr','testthat','data.table','reshape2','grDevices','graphics','stats','utils','Rcpp','kableExtra','rlang','knitr','rmarkdown'))
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("RSeqAn","seqTools","zlibbioc")
```

## Installing

### From Github repo

Currently this is the only way to install `qckitfastq`. You will need `devtools`. Once the package is approved on Bioconductor, this repository will contain the development version rather than the release version.
```{r}
devtools::install_github("compbiocore/qckitfastq",build_vignettes=TRUE)
library(qckitfastq)
```

### From Bioconductor

Package has been submitted and is currently pending review on Bioconductor.

## Usage

The simplest way to run `qckitfastq` and its intended usage is by executing `run_all`, a single command that will produce a report of all of the included metrics in a user-provided directory with some default parameters and default filenames. These default parameters and filenames cannot be changed. An example using `tempdir()` and an example `fq.gz` file is given below:
```r
library(qckitfastq)
infile <- system.file("extdata","10^5_reads_test.fq.gz",package="qckitfastq")
testfolder <- tempdir()
run_all(infile,testfolder)
```

However, each metric can also be run separately for closer examination, parameter tuning, or if the user wishes to save reports with a different filename. In those cases, we recommend taking a look at the [`qckitfastq` vignette](https://compbiocore.github.io/qckitfastq/vignette-qckitfastq/) to get started. The vignette can also be viewed in RStudio with the following commands:
```{r}
library(qckitfastq)
browseVignettes("qckitfastq")
```

## Release history

See [`NEWS`](https://github.com/compbiocore/qckitfastq/blob/master/inst/NEWS/) for changes.

## Authors

 * August Guang, creator and maintainer.
 * Wenyue Xing, creator.


