#' Plot the mean quality score per sequence as a histogram.
#' High quality sequences are those mostly distributed over 30.
#' Low quality sequences are those mostly under 30.
#' \code{plot_perseq_quality}
#' @param infile Path to FASTQ file
#' @param output_file File to write plot to. Will not write to file if NA. Default NA.
#' @examples
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' plot_perseq_quality(infile)
#' @return Plot of mean quality score per read
#' @export
plot_perseq_quality <- function(infile,output_file=NA){

  score_sequence_mean <- data.frame(qual_score_per_read(infile))
  colnames(score_sequence_mean)[1] <- c("sequencemean")

  p1 <- ggplot2::ggplot(data=score_sequence_mean,
                        ggplot2::aes(.data$sequencemean)) +
    ggplot2::geom_histogram(bins=30)
  p_perseq_quality <- p1 +
    ggplot2::labs(title="Histograms of per sequence mean quality",
                  x= "Mean Quality Score",
                  y = "Frequency")
  if (!is.na(output_file)){ggplot2::ggsave(file=output_file,p_perseq_quality)}

  return(p_perseq_quality)
}
