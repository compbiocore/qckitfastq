# `overrep_kmer`: Generate overrepresented kmers of length k based on their observed to expected ratio at each position
 across all sequences in the dataset. The expected proportion of a length k kmer assumes site independence
 and is computed as the sum of the count of each base pair in the kmer times the probability of observing
 that base pair in the data set, i.e. P(A)count_in_kmer(A) + P(C)count_in_kmer(C) + ... The observed to expected
 ratio is computed as log2(obs/exp). Those with obsexp_ratio > 2 are considered to be overrepresented and appear
 in the returned data frame along with their position in the sequence.

## Description


 Generate overrepresented kmers of length k based on their observed to expected ratio at each position
 across all sequences in the dataset. The expected proportion of a length k kmer assumes site independence
 and is computed as the sum of the count of each base pair in the kmer times the probability of observing
 that base pair in the data set, i.e. P(A)count_in_kmer(A) + P(C)count_in_kmer(C) + ... The observed to expected
 ratio is computed as log2(obs/exp). Those with obsexp_ratio > 2 are considered to be overrepresented and appear
 in the returned data frame along with their position in the sequence.


## Usage

```r
overrep_kmer(path, k, nc, nr, output_file = NA)
```


## Arguments

Argument      |Description
------------- |----------------
```path```     |     path to the FASTQ file
```k```     |     the kmer length
```nc```     |     number of positions
```nr```     |     number of reads
```output_file```     |     File to save plot to. Will not write to file if NA. Default NA.

## Value


 A data frame with the columns: Position (in the read), Obsexp_ratio, and Kmer


## Examples

```r 
 
 path <-system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 overrep_kmer(path,k=4,nc=100,nr=25000)
 
 ``` 

