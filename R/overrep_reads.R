#' Sort all sequences per read by count.
#' 
#' @param infile Path to gzippped FASTQ file.
#' @param output_file File to save data frame to. Default NA.
#'
#' @return Table of sequences sorted by count.
#' @examples
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz",
#'     package = "qckitfastq")
#' overrep_reads(infile)[1:5,]
#' @importFrom utils write.csv
#' @export
overrep_reads <- function(infile,output_file=NA){
  over_rep <- calc_over_rep_seq(infile)
  over_rep_table <- sort(over_rep[over_rep>0.001*sum(over_rep)],decreasing=TRUE)
  overrep_df <- data.frame(read_sequence=names(over_rep_table),count=over_rep_table)
  rownames(overrep_df) <- seq(1, nrow(overrep_df))
  if (!is.na(output_file)){write.csv(file=output_file,overrep_df)}
  return(overrep_df)
}