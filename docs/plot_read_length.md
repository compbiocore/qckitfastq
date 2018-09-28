# `plot_read_length`: Extract the read length per read and plot a corresponding histogram of the number
 of reads with each read length.

## Description


 Extract the read length per read and plot a corresponding histogram of the number
 of reads with each read length.


## Usage

```r
plot_read_length(fseq, output_file = NA)
```


## Arguments

Argument      |Description
------------- |----------------
```fseq```     |     a seqTools object produced by seqTools:fastqq on the raw FASTQ file.
```output_file```     |     If specified, the output file to write to. Default is NA, i.e. do not write to file.

## Value


 A histogram of the read length distribution.


## Author


 Wenyue Xing, wenyue_xing@brown.edu , August Guang, august_guang@brown.edu 


## Examples

```r 
 
 infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 fseq <- seqTools::fastqq(infile,k=6)
 plot_read_length(fseq)
 
 ``` 

