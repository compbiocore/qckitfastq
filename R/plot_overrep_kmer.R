#' Create a box plot of the log2(observed/expected) ratio across the length of the sequence as well as top
#' overrepresented kmers. Only ratios greater than 2 are included in the box plot. Default is 20 bins across
#' the length of the sequence and the top 2 overrepresented kmers, but this can be changed by the user.
#' 
#' @param overkm data frame with columns pos, obsexp_ratio, and kmer
#' @param bins number of intervals across the length of the sequence
#' @param top_num number of most overrepresented kmers to plot
#' @param output_file File to write plot to. Will not write to file if NA. Default NA.
#' @return A box plot of the log2(observed/expected ratio) across the length of the sequence
#' @examples
#' infile <- system.file("extdata", "test.fq.gz",
#'     package = "qckitfastq")
#' over_km <- overrep_kmer(infile,k=4)
#' plot_overrep_kmer(over_km)
#' @importFrom ggplot2 ggplot geom_boxplot geom_text aes labs
#' @importFrom dplyr filter
#' @importFrom rlang .data
#' @export
plot_overrep_kmer <- function(overkm, bins=20, top_num=2, output_file=NA) {
  overkm$bin <- cut(overkm$position, breaks=bins)
  kmers <- c(overkm$kmer[seq_len(top_num)],rep(NA,nrow(overkm)-top_num))
  overkm$outlier <- kmers
  # To address R CMD check from giving a NOTE about undefined global variables
  # https://dplyr.tidyverse.org/articles/programming.html
  p<-ggplot(overkm, aes(x=.data$position,y=.data$obsexp_ratio,group=.data$bin)) +
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
#' @return currently 0 as function is not fully working.
#' @importFrom utils combn
plot_outliers <- function(overkm, top_num) {
  subset <- overkm[seq_len(top_num),]
  binned_points <- split(subset, as.character(subset$bin))
  combos <- lapply(binned_points, function(x) combn(x$obsexp_ratio,2))
  kmer_combos <- lapply(binned_points, function(x) combn(x$kmer, 2))
  diffs <- lapply(combos, function(x) which(x[1,]-x[2,]>.4)) # which combos have difference < .4?
  test <- mapply(function(x,y) paste(x[,y], collapse=" "), kmer_combos, diffs)
  return(0)
}