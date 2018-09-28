# `GC_content`: Calculates GC content percentage for each read in the dataset.

## Description


 Calculates GC content percentage for each read in the dataset.


## Usage

```r
GC_content(infile, output_file = NA)
```


## Arguments

Argument      |Description
------------- |----------------
```infile```     |     the object that is the path to the FASTQ file
```output_file```     |     File to write results in CSV format to. Will not write to file if NA. Default NA.

## Value


 plot of GC content


## Examples

```r 
 
 infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 head(GC_content(infile))
 
 ``` 

