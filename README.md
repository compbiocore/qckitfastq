[![Travis](https://img.shields.io/travis/compbiocore/qckitfastq.svg?style=flat-square)](https://travis-ci.org/compbiocore/qckitfastq) [![coverage](https://img.shields.io/codecov/c/github/compbiocore/qckitfastq.svg?style=flat-square)](https://codecov.io/gh/compbiocore/qckitfastq) [![Docs](https://img.shields.io/badge/docs-stable-steelblue.svg?style=flat-square)](https://compbiocore.github.io/qckitfastq)

# qckitfastq: The comprehensive quality control tool for Next Generation Sequencing FASTQ data

This package contains tools for comprehensive quality control of FASTQ format data. In this package, we hope to replicate existing tools for FASTQ quality control as well as advance FASTQ metrics where data is truncated for the analysis. 

We enable efficient processing of FASTQ format data by implementing efficient C++ functions using `Rcpp`. 

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

## Existing Tools

### FASTQC
### seqTools
### ShortRead


## Installation
### Installation from Github repo

```{r}
devtools::install_github("compbiocore/qckitfastq",build_vignettes=TRUE)
library(qckitfastq)
```

### Installation from Bioconductor(add later)

## Getting started

You can explore how the package analyze a FASTQ format sequencing data. 


```{r}
library(qckitfastq)
browseVignettes("qckitfastq")
``` 



