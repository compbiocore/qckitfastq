#' Extract the read length per read and plot a corresponding histogram of the number
#' of reads with each read length.
#'
#' @param fseq a seqTools object produced by seqTools:fastqq on the raw FASTQ file.
#' @param output_file If specified, the output file to write to. Default is NA, i.e. do not write to file.
#' @examples
#'
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' fseq <- seqTools::fastqq(infile,k=6)
#' plot_read_length(fseq)
#'
#' @importFrom dplyr count
#'
#' @return A histogram of the read length distribution.
#' @author Wenyue Xing, \email{wenyue_xing@@brown.edu}, August Guang, \email{august_guang@@brown.edu}
#' @export
plot_read_length <- function(fseq,output_file=NA){

  len_table <- as.data.frame(seqTools::seqLenCount(fseq))
  colnames(len_table) = c("count")
  len_table$seq_length = as.numeric(rownames(len_table))

  p1 <-with(len_table,ggplot2::ggplot(len_table,ggplot2::aes(x=seq_length,y=count))+ggplot2::geom_bar(stat="identity"))
  p2 <-p1 + with(len_table,ggplot2::geom_text(ggplot2::aes(label=count), vjust=0))
  p_sequence_length <- p2 + ggplot2::labs(x = "Sequence length", y = "Number of reads with sequence length specified",title = "Sequence length distribution")
  if(!is.na(output_file)){ggplot2::ggsave(file=output_file,p_sequence_length)}

  return(p_sequence_length)
}

