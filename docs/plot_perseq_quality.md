# `plot_perseq_quality`: Plot the mean quality score per sequence as a histogram.
 High quality sequences are those mostly distributed over 30. Low quality sequences are those mostly under 30.
 `plot_perseq_quality`

## Description


 Plot the mean quality score per sequence as a histogram.
 High quality sequences are those mostly distributed over 30. Low quality sequences are those mostly under 30.
 `plot_perseq_quality` 


## Usage

```r
plot_perseq_quality(infile, output_file = NA)
```


## Arguments

Argument      |Description
------------- |----------------
```infile```     |     Path to FASTQ file
```output_file```     |     File to write plot to. Will not write to file if NA. Default NA.

## Value


 Plot of mean quality score per read


## Examples

```r 
 infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 plot_perseq_quality(infile)
 ``` 

