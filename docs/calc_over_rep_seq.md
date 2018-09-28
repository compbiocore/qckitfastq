# `calc_over_rep_seq`: Calculate sequece counts for each unique sequence and create a table with unique sequences
 and corresponding counts

## Description


 Calculate sequece counts for each unique sequence and create a table with unique sequences
 and corresponding counts


## Usage

```r
calc_over_rep_seq(infile, min_size = 5L, buffer_size = 1000000L)
```


## Arguments

Argument      |Description
------------- |----------------
```infile```     |     A string giving the path for the fastqfile
```min_size```     |     An int for thhresholding over representation
```buffer_size```     |     An int for the number of lines to keep in memory

## Value


 calculate overrepresented sequence count


