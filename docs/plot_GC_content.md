# `plot_GC_content`: Generate GC content plot

## Description


 Generate GC content plot


## Usage

```r
plot_GC_content(nc, gc_df, output_file = NA)
```


## Arguments

Argument      |Description
------------- |----------------
```nc```     |     The number of base pairs to bin by
```gc_df```     |     the object that is the GC content vectors generated from GC content function
```output_file```     |     File to write plot to. Will not write to file if NA. Default NA.

## Value


 A histogram of the GC content acorss all positions


## Examples

```r 
 
 infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 gc_df<-GC_content(infile)
 plot_GC_content(nc=100,gc_df)
 
 ``` 

