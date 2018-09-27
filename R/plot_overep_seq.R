#' Plot the top 5 seqeunces
#' @param overrep_order the table that sorts the sequence content and corresponding counts in descending order
#' @param output_file File to save plot to. Will not write to file if NA. Default NA.
#'
#' @return plot of the top 5 overrepresented sequences
#' @examples
#'
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' overrep_order <- overrep_sequence(infile,nr=25000,"test")
#' plot_overrep_seq(overrep_order)
#'
#' @importFrom grDevices pdf dev.off
#' @importFrom graphics plot rug
#' @importFrom stats density
#' @export
plot_overrep_seq <- function(overrep_order,output_file=NA){
  if (!is.na(output_file)){
  pdf(file = output_file)
  plot(density(overrep_order),main = "Overrepresented Sequence Histogram with top 5 rug",ylab="Density",xlab="Sequence Count")
  rug(overrep_order[1:5],col=2, lwd=3.5)
  dev.off()
  }else{
    plot(density(overrep_order),main = "Overrepresented Sequence Histogram with top 5 rug",ylab="Density",xlab="Sequence Count")
    rug(overrep_order[1:5],col=2, lwd=3.5)
  }
}
