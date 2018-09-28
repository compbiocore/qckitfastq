# `dimensions`: Extract the number of columns and rows for a FASTQ file using seqTools.

## Description


 Extract the number of columns and rows for a FASTQ file using seqTools.


## Usage

```r
dimensions(fseq, selection)
```


## Arguments

Argument      |Description
------------- |----------------
```fseq```     |     an object that is the read result of the seq.read function
```selection```     |     "reads' for number of reads/rows, 'positions' for number of positions/columns

## Value


 a numeric value of the number of reads or the number of positions


## Examples

```r 
 
 infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 fseq <- seqTools::fastqq(infile,k=6)
 dimensions(fseq,"reads")
 
 ``` 

