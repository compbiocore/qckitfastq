# `plot_overrep_seq`: Plot the top 5 seqeunces

## Description


 Plot the top 5 seqeunces


## Usage

```r
plot_overrep_seq(overrep_order, output_file = NA)
```


## Arguments

Argument      |Description
------------- |----------------
```overrep_order```     |     the table that sorts the sequence content and corresponding counts in descending order
```output_file```     |     File to save plot to. Will not write to file if NA. Default NA.

## Value


 plot of the top 5 overrepresented sequences


## Examples

```r 
 
 infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 overrep_order <- overrep_sequence(infile,nr=25000,"test")
 plot_overrep_seq(overrep_order)
 
 ``` 

