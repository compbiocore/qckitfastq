# `per_base_quality`: Compute the mean, median, and percentiles of quality score per base. This is returned
 as a data frame.

## Description


 Compute the mean, median, and percentiles of quality score per base. This is returned
 as a data frame.


## Usage

```r
per_base_quality(infile, output_file = NA)
```


## Arguments

Argument      |Description
------------- |----------------
```infile```     |     from basic statistics function
```output_file```     |     File to write results in CSV format to. Will not write to file if NA. Default NA.

## Value


 A dataframe of the mean, median and quantiles of the FASTQ file


## Author


 Wenyue Xing, wenyue_xing@brown.edu , August Guang, august_guang@brown.edu 


## Examples

```r 
 per_base_quality(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))
 ``` 

