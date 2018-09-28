# `plot_sequence_content`: Plot the per position nucleotide content

## Description


 Plot the per position nucleotide content


## Usage

```r
plot_sequence_content(fseq, nr, nc, output_file = NA)
```


## Arguments

Argument      |Description
------------- |----------------
```fseq```     |     the object that is the processed intermediate product of seqTools fastqq
```nr```     |     the number of reads of the FASTQ file, acquired through previous functions
```nc```     |     the number of positions of the FASTQ file, acquired through previous functions
```output_file```     |     File to save plot to. Will not write to file if NA. Default NA.

## Value


 ggplot line plot of all nucleotide content inclding  A, T, G, C and N


## Examples

```r 
 infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 fseq <- seqTools::fastqq(infile,k=6)
 plot_sequence_content(fseq,nr=25000,nc=100)
 ``` 

