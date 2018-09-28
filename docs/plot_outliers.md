# `plot_outliers`: Determine how to plot outliers. Heuristic used is whether their obsexp_ratio differs by more than 1
 and whether they fall into the same bin or not. If for 2 outliers, obsexp_ratio differs by less than .4
 and they are in the same bin, then combine into a single plotting point.
 NOT FULLY FUNCTIONAL

## Description


 Determine how to plot outliers. Heuristic used is whether their obsexp_ratio differs by more than 1
 and whether they fall into the same bin or not. If for 2 outliers, obsexp_ratio differs by less than .4
 and they are in the same bin, then combine into a single plotting point.
 NOT FULLY FUNCTIONAL


## Usage

```r
plot_outliers(overkm, top_num)
```


## Arguments

Argument      |Description
------------- |----------------
```overkm```     |     data frame with columns pos, obsexp_ratio, and kmer that has already been reordered by descending obsexp_ratio
```top_num```     |     number of most overrepresented kmers to plot. Default is 5.

