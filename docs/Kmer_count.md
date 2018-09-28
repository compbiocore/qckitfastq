# `kmer_count`: Return kmer count per sequence for the length of kmer desired

## Description


 Return kmer count per sequence for the length of kmer desired


## Usage

```r
kmer_count(infile, k, output_file = NA)
```


## Arguments

Argument      |Description
------------- |----------------
```infile```     |     the object that is the path to gzippped FASTQ file
```k```     |     the length of kmer
```output_file```     |     File to save plot to. Will not write to file if NA. Default NA.

## Value


 kmers counts per sequence


## Examples

```r 
 
 infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 km<-kmer_count(infile,k=4)
 km[1:20,1:10]
 
 ``` 

