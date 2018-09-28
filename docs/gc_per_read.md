# `gc_per_read`: Calculate GC nucleotide sequence content per read of the FASTQ gzipped file

## Description


 Calculate GC nucleotide sequence content per read of the FASTQ gzipped file


## Usage

```r
gc_per_read(infile)
```


## Arguments

Argument      |Description
------------- |----------------
```infile```     |     A string giving the path for the fastqfile

## Value


 GC content perncentage per read


## Examples

```r 
 infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 gc_per_read(infile)[1:10]
 ``` 

