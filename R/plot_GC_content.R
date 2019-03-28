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
#' @importFrom ggplot2 ggplot geom_col scale_x_discrete aes labs
#' @export

plot_GC_content <- function(gc_df,output_file=NA){
  p <- ggplot(data=gc_df) + geom_col(aes(x=.data$GC_content,y=.data$count)) +
      scale_x_discrete(breaks=seq(0,100,by=10)) +
      labs(title="Binned read counts by GC content percentage", x = "GC content percentage", y = "Count")
  if (!is.na(output_file)){ggplot2::ggsave(file=output_file,p)}
  return(p)
}