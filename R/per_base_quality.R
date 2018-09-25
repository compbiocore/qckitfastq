#' Compute the mean, median, and percentiles of quality score per base. This is returned
#' as a data frame.
#'
#' @param infile  from basic statistics function
#' @param output_file File to write results in CSV format to. Will not write to file if NA. Default NA.
#' @return A dataframe of the mean, median and quantiles of the FASTQ file
#' @examples
#' per_base_quality(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))
#' @importFrom utils write.csv
#' @export
#'
#' @author Wenyue Xing, \email{wenyue_xing@@brown.edu}, August Guang, \email{august_guang@@brown.edu}
per_base_quality <- function(infile,output_file=NA){

  qs <- qual_score_per_read(infile)
  bs <- data.frame(q10 = qs$q10_per_position,
                                 q25 = qs$q25_per_position,
                                 median = qs$q50_per_position,
                                 q75 = qs$q75_per_position,
                                 q90 = qs$q90_per_position)
  if (!is.na(output_file)) write.csv(file=output_file,bs)
  return(bs)
}