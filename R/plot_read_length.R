#' Plot a histogram of the number of reads with each read length.
#'
#' @param read_len Data frame of read lengths and number of reads with that length.
#' @param output_file File to save plot to. Default is NA, i.e. do not write to file.
#' @examples
#'
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' fseq <- seqTools::fastqq(infile,k=6)
#' read_len <- read_length(fseq)
#' plot_read_length(read_len)
#'
#' @importFrom dplyr count
#'
#' @return A histogram of the read length distribution.
#' @author Wenyue Xing, \email{wenyue_xing@@brown.edu}, August Guang, \email{august_guang@@brown.edu}
#' @export
plot_read_length <- function(read_len,output_file=NA){
    m <- which(read_len$num_reads==max(read_len$num_reads))
    p1 <-ggplot2::ggplot(data=read_len,ggplot2::aes(x=.data$read_length,y=.data$num_reads)) + 
        ggplot2::geom_bar(stat="identity") +
        ggplot2::geom_text(data=read_len[m,],label=read_len$num_reads[m], vjust=0)
  p_sequence_length <- p1 +
    ggplot2::labs(x = "Sequence length",
                  y = "Number of reads with sequence length",
                  title = "Sequence length distribution")
  if(!is.na(output_file)){ggplot2::ggsave(file=output_file,p_sequence_length)}
  return(p_sequence_length)
}

