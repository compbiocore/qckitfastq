#' Plot the top 5 seqeunces
#' @param overrep_reads the table that sorts the sequence content and corresponding counts in descending order
#' @param output_file File to save plot to. Will not write to file if NA. Default NA.
#'
#' @return plot of the top 5 overrepresented sequences
#' @examples
#'
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' overrep_df <- overrep_reads(infile)
#' plot_overrep_reads(overrep_df)
#'
#' @importFrom grDevices pdf dev.off
#' @importFrom graphics plot rug
#' @importFrom stats density
#' @importFrom ggplot2 ggplot geom_density geom_rug aes ggtitle ylab xlab ggsave
#' @export
plot_overrep_reads <- function(overrep_reads,output_file=NA){
  p <- ggplot(data=overrep_reads, aes(x=count)) + geom_density() +
      geom_rug(data=overrep_reads[seq_len(5),]) +
      ggtitle("Overrepresented Sequence Histogram with top 5 rug") +
      ylab("Density") +
      xlab("Sequence Count")
  if (!is.na(output_file)){ggsave(output_file,p)}
  return(p)
}
