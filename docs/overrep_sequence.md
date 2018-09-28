# `overrep_sequence`: Sort all sequences per read by count along with a density plot of all counts with top 5 repreated sequences marked

## Description


 Sort all sequences per read by count along with a density plot of all counts with top 5 repreated sequences marked


## Usage

```r
overrep_sequence(infile, nr, output_file = NA)
```


## Arguments

Argument      |Description
------------- |----------------
```infile```     |     the object that is the path to gzippped FASTQ file
```nr```     |     the number of reads of the FASTQ file
```output_file```     |     File to save data frame to. Will not write to file if NA. Default NA.

## Value


 table of sequnces sortted by count
 
 density plot of sequence length with top 5 marked by rugs, saved as PDF file


## Examples

```r 
 
 infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 overrep_sequence(infile,nr=25000)[1:5]
 ``` 

