1. We have added a section for this in the vignette Introduction under Why Use qckitfastq? I have repasted the contents here:

```text
Indeed there are many other quality control packages for FASTQ files existing already, including ShortReads (TODO: citation)
and seqTools (TODO: citation)
for R and the popular FASTQC (TODO: citation) Java-based program. qckitfastq offers a few advantages
compared to these 3 programs for users who need such features:
  1. access to raw sequence and quality data
  2. quality control analyses of the entire FASTQ file
  3. fast file processing
  
To break it down further, seqTools and ShortReads do not offer as comprehensive set of quality control metrics as
qckitfastq and FASTQC. seqTools further provides limited access to raw data and intermediate analysis results. ShortReads
provides users with access to the raw sequencing data and intermedite analysis results, but is inefficient on datasets
exceeding 10 million reads. FASTQC meanwhile truncates any reads longer than 75bp as well as estimates overall quality
only based on the first 100,000 reads of any FASTQ file. `qckitfastq` does not contain any of these limitations.
```

2. Done.

3. Done.

4. Removed this.

5. Removed the chunk.

6. This has been addressed in the `# Individual metrics` section of the vignette. Essentially, some functions in `qckitfastq` are simply wrappers around `seqTools` functions, and are there for the sake of completeness if the user wants to run a report of all possible quality control metrics for FASTQ data.

7. [Please briefly comment the result of each step of the analysis]

8. This has been removed.

9. Man pages have been updated.

10. Addressed.

11. Changed to `output_file=NA` by default.

12. Addressed.

13. Addressed.