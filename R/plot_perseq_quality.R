#' plot the mean quality score per read in histograms
#' \code{plot_perseq_quality}
#' @param infile the object that is the path to the file that
#' @param writefile the object indicating intent to save the plot as pdf file, set default as FALSE
#' @param prefix the prefix for the output file of the plot
#'
#' @return plot of mean quality score per read
#' @export



plot_perseq_quality <- function(infile,writefile=FALSE,prefix){

  score_sequence_mean <- data.frame(qual_score_per_read(infile))
  colnames(score_sequence_mean)[1] <- c("sequencemean")

  p1 <- with(score_sequence_mean, ggplot2::ggplot(data=score_sequence_mean, ggplot2::aes(sequencemean)) +ggplot2::geom_histogram(bins=30))
  p_perseq_quality <- p1 + ggplot2::labs(title = "Histograms of per sequence mean quality ", x= "Mean Quality Score" , y = "Frequency")
  if (writefile==TRUE){ggplot2::ggsave(file=paste0(prefix,"per_sequence_quality.pdf"),p_perseq_quality)}

  return(p_perseq_quality)
}
