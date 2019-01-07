#' Plot the per position nucleotide content.
#' 
#' @param read_content Data frame produced by read_content function.
#' @param output_file File to save plot to. Will not write to file if NA. Default NA.
#' @examples
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' fseq <- seqTools::fastqq(infile,k=6)
#' read_content <- read_content(fseq)
#' plot_read_content(read_content)
#' @return ggplot line plot of all nucleotide content inclding  A, T, G, C and N
#' @importFrom reshape2 melt
#' @importFrom dplyr %>% transmute select
#' @export
plot_read_content<- function(read_content,output_file=NA){
  read_content$num_reads <- read_content %>% select(.data$a:.data$n) %>% rowSums()
  df <- read_content %>%
      transmute(position=.data$position,
                a=.data$a/.data$num_reads*100,
                c=.data$c/.data$num_reads*100,
                g=.data$g/.data$num_reads*100,
                t=.data$t/.data$num_reads*100,
                n=.data$n/.data$num_reads*100)
  dfm <- reshape2::melt(df,id.vars='position')
  p1 <- ggplot2::ggplot(data=dfm,
                        ggplot2::aes(x=as.numeric(.data$position),
                                     y=.data$value,
                                     colour = .data$variable)) +
      ggplot2::geom_line()
  p2 <- p1 + ggplot2::labs(x = "Position", y= "Percentage of content",
                           title = "Per base sequence content percentage")
  p_content <- p2 + ggplot2::guides(fill=ggplot2::guide_legend(title="Sequence Content"))
  if(!is.na(output_file)){ggplot2::ggsave(file=output_file,p_content)}
  return(p_content)
}