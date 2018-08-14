#' Generate the data frame that includes percentiles of quality score per position
#'
#' @param infile  from basic statistics function
#' @param output_file File to write results in CSV format to. Will not write to file if NA. Default NA.
#' @return A dataframe of the mean, median and quantiles of the FASTQ file
#' @examples
#'
#' basic_stat(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"),FALSE)
#'
#' @export
#'
#' @author Wenyue Xing, \email{wenyue_xing@@brown.edu}, August Guang, \email{august_guang@@brown.edu}
basic_stat <- function(infile,output_file=NA){

  qs <- qual_score_per_read(infile)
  bs <- data.frame(q01 = qs$q01_per_position,
                                 q25 = qs$q25_per_position,
                                 median = qs$q50_per_position,
                                 q75 = qs$q75_per_position,
                                 q99 = qs$q99_per_position)
  if (output_file) write.csv(file=output_file,bs)
  return(bs)
}