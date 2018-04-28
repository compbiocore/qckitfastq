#' Generate a boxplot of the per posistion quality score from basic statistics results
#' @param bs the object that is the dataframe of the mean, median and quantiles of the FASTQ file from basic statistics function
#' @param writefile the object indicating intent to save the plot as pdf file, set default as FALSE
#' @param prefix the prefix for the output file of the plot
#'
#' @export
#'
#' @return boxplot of per position quality score distribution


plot_quality_score <- function(basic_statistics, writefile=FALSE,prefix){

  colnames(basic_statistics) <- c("min","q25","median","q75","max")
  basic_statistics$index = seq(1,nrow(basic_statistics),1)

  p_1 <- with(basic_statistics,ggplot2::ggplot(data=basic_statistics,ggplot2::aes(x=index))+ggplot2::geom_boxplot(ggplot2::aes(ymin=min,lower=q25,middle = median,upper = q75,ymax = max),stat="identity")+ggplot2::scale_y_continuous(limits = c(0, 50)))
  p_quality_score <- p_1 + ggplot2::labs(x = "Positions", y = "Number",title = "Quality score distribution per position")
  if (writefile==TRUE){ggplot2::ggsave(file=paste0(prefix,"quality_score.pdf"),p_quality_score)}

  return(p_quality_score)
}
