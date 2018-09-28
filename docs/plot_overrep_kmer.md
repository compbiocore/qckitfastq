# `plot_overrep_kmer`: Create a box plot of the log2(observed/expected) ratio across the length of the sequence as well as top
 overrepresented kmers. Only ratios greater than 2 are included in the box plot. Default is 20 bins across
 the length of the sequence and the top 2 overrepresented kmers, but this can be changed by the user.

## Description


 Create a box plot of the log2(observed/expected) ratio across the length of the sequence as well as top
 overrepresented kmers. Only ratios greater than 2 are included in the box plot. Default is 20 bins across
 the length of the sequence and the top 2 overrepresented kmers, but this can be changed by the user.


## Usage

```r
plot_overrep_kmer(overkm, bins = 20, top_num = 2, output_file = NA)
```


## Arguments

Argument      |Description
------------- |----------------
```overkm```     |     data frame with columns pos, obsexp_ratio, and kmer
```bins```     |     number of intervals across the length of the sequence
```top_num```     |     number of most overrepresented kmers to plot
```output_file```     |     File to write plot to. Will not write to file if NA. Default NA.

