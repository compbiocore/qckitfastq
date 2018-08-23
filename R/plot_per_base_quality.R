#' Generate a boxplot of the per position quality score.
#' 
#' @param per_base_quality a data frame of the mean, median and quantiles of sequence quality per base. Most likely generated with the `per_base_quality` function.
#' @param output_file File to save plot to. Will not write to file if NA. Default NA.
#'
#' @export
#' @examples
#'
#' pbq <- per_base_quality(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))
#' plot_per_base_quality(pbq)
#' @return A boxplot of per position quality score distribution.
plot_per_base_quality <- function(per_base_quality, output_file=NA){

  colnames(per_base_quality) <- c("min","q25","median","q75","max")
  per_base_quality$index = seq(1,nrow(per_base_quality),1)

  p_1 <- with(per_base_quality,ggplot2::ggplot(data=per_base_quality,ggplot2::aes(x=index))+ggplot2::geom_boxplot(ggplot2::aes(ymin=min,lower=q25,middle = median,upper = q75,ymax = max),stat="identity")+ggplot2::scale_y_continuous(limits = c(0, 50)))
  p_quality_score <- p_1 + ggplot2::labs(x = "Positions", y = "Number",title = "Quality score distribution per position")
  
  if(!is.na(output_file)) {ggplot2::ggsave(file=output_file,p_quality_score)}

  return(p_quality_score)
}