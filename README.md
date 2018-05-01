# qckitfastq: The comprehensive quality control tool for Next Generation Sequencing data in FASTQC format

This package contains tools for the comprehensive quality control of FASTQC format data. In this package, we hope to replicate exsting tool FASTQC metrices where analysis on entire dataset is operated. We also aim to advance FASTQC metrices where data is truncated for the analysis. 

We enable efficient processing of FASTQ format data by implementing efficient c++ functions using `Rcpp`. 

The metrices that `qckit` provides are as following:
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



