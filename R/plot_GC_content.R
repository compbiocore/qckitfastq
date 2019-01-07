#' Generate mean GC content histogram.
#' 
#' @param gc_df the object that is the GC content vectors generated from GC content function
#' @param output_file File to write plot to. Will not write to file if NA. Default NA.
#' @return A histogram of mean GC content.
#'
#' @examples
#'
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' gc_df<-GC_content(infile)
#' plot_GC_content(gc_df)
#'
#' @export

plot_GC_content <- function(gc_df,output_file=NA){
  p1 <- ggplot2::ggplot(data=gc_df, ggplot2::aes(.data$mean_GC)) + 
               ggplot2::geom_histogram(breaks=seq(0, 100, by=1))
  p_GC <- p1 + ggplot2::labs(title = "Histograms for GC content percentage", x= "Mean GC content percentage" , y = "Frequency")
  if (!is.na(output_file)){ggplot2::ggsave(file=output_file,p_GC)}
  return(p_GC)
}