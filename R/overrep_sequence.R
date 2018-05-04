#' Sort all sequences per read by count along with a density plot of all counts with top 5 repreated sequences marked
#' @param infile the object that is the path to gzippped FASTQ file
#' @param nr the number of reads of the FASTQ file
#' @param writefile TRUE for writing the output to csv file
#' @param prefix prefix of output file if writefile is TRUE
#'
#' @return  table of sequnces sortted by count
#' @return  density plot of sequence length with top 5 marked by rugs, saved as PDF file
#'
#' @examples
#'
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' overrep_sequence(infile,nr=25000)
#'
#' @export
overrep_sequence <- function(infile,nr,writefile=FALSE,prefix){

  over_rep <- calc_over_rep_seq(infile,prefix)
  over_rep_table <- over_rep[over_rep>0.001*nr]
  overrep_order <- sort(over_rep_table,decreasing=TRUE)
  if (writefile==TRUE){write.csv(file=paste0(prefix,"Overrepresented_Sequence.csv"),overrep_order)}
  return(overrep_order)

}

