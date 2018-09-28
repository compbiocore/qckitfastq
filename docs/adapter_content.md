# `adapter_content`: Search through sequences and return the total proportion of the library which contains
 adapter sequences, predefined in the file adapters.txt. It is also possible for the user to
 give a different file as input; the function is relatively generic. Sequences however must
 be in the same format as adapters.txt, that is name tab sequence.

## Description


 Search through sequences and return the total proportion of the library which contains
 adapter sequences, predefined in the file adapters.txt. It is also possible for the user to
 give a different file as input; the function is relatively generic. Sequences however must
 be in the same format as adapters.txt, that is name tab sequence.


## Usage

```r
adapter_content(infile, adapter_file)
```


## Arguments

Argument      |Description
------------- |----------------
```infile```     |     the path to the FASTQ file
```adapter_file```     |     filepath to the adapter sequences to search for. Default is extdata/adapters.txt.

## Value


 proportion of adapter sequences]


