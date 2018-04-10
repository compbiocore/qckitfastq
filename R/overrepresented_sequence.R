#' Sort all sequences per read by count along with a density plot of all counts with top 5 repreated sequences marked
#' @param infile the object that is the path to gzippped FASTQ file
#' @param prefix the prefix to name the output file
#' @param nr the number of reads of the FASTQ file
#' @return  table of sequnces sortted by count
#' @return  density plot of sequence length with top 5 marked by rugs, saved as PDF file
#' @export



overrepresented_sequence <- function(infile,nr,prefix){

  over_rep <- calc_over_rep_seq(infile,prefix)
  over_rep_table <- over_rep[over_rep>0.001*nr]
  overrep_order <- sort(over_rep_table,decreasing=TRUE)
  write.csv(overrep_order,file = paste0(prefix,"overrepresented_sequence.csv"))
  return(overrep_order)

}

