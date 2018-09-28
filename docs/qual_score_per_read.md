# `qual_score_per_read`: Calculate the mean quality score per read of the FASTQ gzipped file

## Description


 Calculate the mean quality score per read of the FASTQ gzipped file


## Usage

```r
qual_score_per_read(infile)
```


## Arguments

Argument      |Description
------------- |----------------
```infile```     |     A string giving the path for the fastqfile

## Value


 mean quality per read


## Examples

```r 
 infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 qual_score_per_read(infile)$q50_per_position[1:10]
 ``` 

