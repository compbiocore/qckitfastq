#' Generate a boxplot of the per position quality score.
#' 
#' @param per_base_quality a data frame of the mean, median and quantiles of sequence quality per base. Most likely generated with the `per_base_quality` function.
#' @param output_file File to save plot to. Will not write to file if NA. Default NA.
#' @export
#' @examples
#'
#' pbq <- per_base_quality(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))
#' plot_per_base_quality(pbq)
#' @return A boxplot of per position quality score distribution.
#' @importFrom rlang .data
plot_per_base_quality <- function(per_base_quality, output_file=NA){
    
  # To address R CMD check from giving a NOTE about undefined global variables
  # https://dplyr.tidyverse.org/articles/programming.html
  p_quality_score <- ggplot2::ggplot(data=per_base_quality,aes(x=.data$position)) +
    ggplot2::labs(x = "Position", y = "Quality Score",title = "Quality score distribution per position") +
    ggplot2::geom_rect(aes(ymin=28,ymax=Inf,xmin=-Inf,xmax=Inf),fill='lightgreen',alpha=.02) +
    ggplot2::geom_rect(aes(ymin=20,ymax=28,xmin=-Inf,xmax=Inf),fill='yellow',alpha=.02) +
    ggplot2::geom_rect(aes(ymin=-Inf,ymax=20,xmin=-Inf,xmax=Inf),fill='red',alpha=.01) +
    ggplot2::geom_boxplot(ggplot2::aes(ymin=.data$q10,lower=.data$q25,middle = .data$median,
                                       upper = .data$q75,ymax=.data$q90,group=.data$position),stat="identity")
  
  if(!is.na(output_file)) {ggplot2::ggsave(file=output_file,p_quality_score)}

  return(p_quality_score)
}