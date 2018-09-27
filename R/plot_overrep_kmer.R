#' Create a box plot of the log2(observed/expected) ratio across the length of the sequence as well as top
#' overrepresented kmers. Only ratios greater than 2 are included in the box plot. Default is 20 bins across
#' the length of the sequence and the top 2 overrepresented kmers, but this can be changed by the user.
#' 
#' @param overkm data frame with columns pos, obsexp_ratio, and kmer
#' @param bins number of intervals across the length of the sequence
#' @param top_num number of most overrepresented kmers to plot
#' @param output_file File to write plot to. Will not write to file if NA. Default NA.
#' @importFrom ggplot2 ggplot geom_boxplot geom_text aes labs
#' @importFrom dplyr filter
#' To address R CMD check from giving a NOTE about undefined global variables
#' https://dplyr.tidyverse.org/articles/programming.html
#' @importFrom rlang .data
#' @export
plot_overrep_kmer <- function(overkm, bins=20, top_num=2, output_file=NA) {
  overkm$bin <- cut(overkm$pos, breaks=bins)
  kmers <- c(overkm$kmer[1:top_num],rep(NA,nrow(overkm)-top_num))
  overkm$outlier <- kmers
  p<-ggplot(overkm, aes(x=.data$pos,y=.data$obsexp_ratio,group=.data$bin)) +
    geom_boxplot(outlier.color="red") +
    geom_text(aes(label=.data$outlier),na.rm=TRUE,hjust=-0.3) +
    labs(title="Boxplot of log2(Observed/Expected) Kmer ratio",
         x="Position",
         y="log2(Observed/Expected) Kmer ratio")
  if (!is.na(output_file)) {ggplot2::ggsave(file=output_file,p)}
  return(p)
}

#' Determine how to plot outliers. Heuristic used is whether their obsexp_ratio differs by more than 1
#' and whether they fall into the same bin or not. If for 2 outliers, obsexp_ratio differs by less than .4
#' and they are in the same bin, then combine into a single plotting point.
#' NOT FULLY FUNCTIONAL
#'
#' @param overkm data frame with columns pos, obsexp_ratio, and kmer that has already been reordered by descending obsexp_ratio
#' @param top_num number of most overrepresented kmers to plot. Default is 5.
#' @importFrom utils combn
plot_outliers <- function(overkm, top_num) {
  subset <- overkm[1:top_num,]
  binned_points <- split(subset, as.character(subset$bin))
  combos <- lapply(binned_points, function(x) combn(x$obsexp_ratio,2))
  kmer_combos <- lapply(binned_points, function(x) combn(x$kmer, 2))
  diffs <- lapply(combos, function(x) which(x[1,]-x[2,]>.4)) # which combos have difference < .4?
  test <- mapply(function(x,y) paste(x[,y], collapse=" "), kmer_combos, diffs)
  return(0)
}