# `process_fastq`: calculate Over Rep seqs

## Description


 calculate Over Rep seqs


## Usage

```r
process_fastq(infile, buffer_size)
```


## Arguments

Argument      |Description
------------- |----------------
```infile```     |     A string giving the path for the fastqfile
```buffer_size```     |     An int for the number of lines to keep in memory

## Value


 process fastq and generate sequence and quality score tables


## Examples

```r 
 infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 process_fastq(infile,10000)
 ``` 

