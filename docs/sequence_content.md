# `sequence_content`: Compute nucleoctide sequence content per position. Wrapper function around seqTools.

## Description


 Compute nucleoctide sequence content per position. Wrapper function around seqTools.


## Usage

```r
sequence_content(fseq, content, output_file = NA)
```


## Arguments

Argument      |Description
------------- |----------------
```fseq```     |     a seqTools::fastqq object
```content```     |     an object of string type that specifies the content in question, "A","T","G","C","N"(either capital or lower case)
```output_file```     |     File to write results in CSV format to. Will not write to file if NA. Default NA.

## Value


 Nucleotide sequence content per position.


## Author


 Wenyue Xing, wenyue_xing@brown.edu , August Guang august_guang@brown.edu 


## Examples

```r 
 infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
 fseq <- seqTools::fastqq(infile,k=6)
 sequence_content(fseq,"A")
 ``` 

