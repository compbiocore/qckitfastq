#' Creates a sorted from most frequent to least frequent abundance table of adapters that are found to be present in
#' the reads at greater than 0.1\% of the reads.
#' @param infile the path to a gzippped FASTQ file
#' @param nr the number of reads of the FASTQ file
#' @param adapter_file Path to the adapters.txt file. Default is the adapters.txt provided in the package based off of FASTQC.
#' @param output_file File to save data frame to. Will not write to file if NA. Default NA.
#' @return Sorted table of adapters and counts.
#'
#' @examples
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' adapter_content(infile,nr=25000)[1:5]
#' @importFrom utils write.csv
#' @export
adapter_content <- function(infile,nr,adapter_file=system.file("extdata", "adapters.txt", package = "qckitfastq"),output_file=NA){
  ac <- calc_adapter_content(infile, adapter_file)
  ac_table <- ac[ac>0.001*nr]
  ac_sorted <- sort(ac_table,decreasing=TRUE)
  if (!is.na(output_file)){write.csv(file=output_file,ac_sorted)}
  return(ac_sorted)
}