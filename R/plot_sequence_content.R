#' Plot the per position nucleotide content
#' \code{plotSeqContent}
#' @param fseq the object that is the processed intermediate product of seqTools fastqq
#' @param nr the number of reads of the FASTQ file, acquired through previous functions
#' @param nc the number of positions of the FASTQ file, acquired through previous functions
#' @param writefile the boolean object to write the plot as PDF file, default is FALSE
#' @param prefix the prefix to add to the file name
#'
#' @return ggplot line plot of all nucleotide content inclding  A, T, G, C and N
#' @export

plotSeqContent<- function(fseq,nr,nc,writefile=FALSE,prefix){

  G_content<- sequence_content(fseq,"G")
  C_content<- sequence_content(fseq,"C")
  T_content<- sequence_content(fseq,"T")
  A_content<- sequence_content(fseq,"A")
  N_content<- sequence_content(fseq,"N")

  df <- data.frame(G_content,C_content,T_content,A_content,N_content)/nr*nc
  dfm <- reshape2::melt(df)
  dfm$position <- rep(seq(1,nc,1), 5)
  p1 <- with(dfm, ggplot2::ggplot(dfm,ggplot2::aes(x= as.numeric(position),y=value,colour = variable))+ggplot2::geom_line())
  p2 <- p1 + ggplot2::labs(x = "Position", y= "Percentage of content", title = "Per base sequence content percentage")
  p_content <- p2 + ggplot2::guides(fill=ggplot2::guide_legend(title="Sequence Content"))
  if (writefile==TRUE){ggplot2::ggsave(file=paste0(prefix,"Seqeunce_content.pdf"),p_content)}
  return(p_content)
}
