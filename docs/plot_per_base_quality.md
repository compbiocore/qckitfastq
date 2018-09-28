# `plot_per_base_quality`: Generate a boxplot of the per position quality score.

## Description


 Generate a boxplot of the per position quality score.


## Usage

```r
plot_per_base_quality(per_base_quality, output_file = NA)
```


## Arguments

Argument      |Description
------------- |----------------
```per_base_quality```     |     a data frame of the mean, median and quantiles of sequence quality per base. Most likely generated with the `per_base_quality` function.
```output_file```     |     File to save plot to. Will not write to file if NA. Default NA.

## Value


 A boxplot of per position quality score distribution.


## Examples

```r 
 
 pbq <- per_base_quality(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))
 plot_per_base_quality(pbq)
 ``` 

