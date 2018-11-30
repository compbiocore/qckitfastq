#' Plot the per position nucleotide content
#' @param fseq the object that is the processed intermediate product of seqTools fastqq
#' @param nr the number of reads of the FASTQ file, acquired through previous functions
#' @param nc the number of positions of the FASTQ file, acquired through previous functions
#' @param output_file File to save plot to. Will not write to file if NA. Default NA.
#' @examples
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' fseq <- seqTools::fastqq(infile,k=6)
#' plot_sequence_content(fseq,nr=25000,nc=100)
#' @return ggplot line plot of all nucleotide content inclding  A, T, G, C and N
#' @export
plot_sequence_content<- function(fseq,nr,nc,output_file=NA){

  G_content<- sequence_content(fseq,"G")
  C_content<- sequence_content(fseq,"C")
  T_content<- sequence_content(fseq,"T")
  A_content<- sequence_content(fseq,"A")
  N_content<- sequence_content(fseq,"N")

  df <- data.frame(G_content,C_content,T_content,A_content,N_content)/nr*nc
  dfm <- reshape2::melt(df)
  dfm$position <- rep(seq(1,nc,1), 5)
  p1 <- ggplot2::ggplot(data=dfm,ggplot2::aes(x=as.numeric(.data$position),y=.data$value,colour = .data$variable))+
    ggplot2::geom_line()
  p2 <- p1 + ggplot2::labs(x = "Position", y= "Percentage of content", title = "Per base sequence content percentage")
  p_content <- p2 + ggplot2::guides(fill=ggplot2::guide_legend(title="Sequence Content"))
  if(!is.na(output_file)){ggplot2::ggsave(file=output_file,p_content)}
  return(p_content)
}
