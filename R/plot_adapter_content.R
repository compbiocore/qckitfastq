#' Creates a bar plot of the top 5 most present adapter sequences.
#' @param ac_sorted Sorted table of adapters and counts.
#' @param output_file File to save data frame to. Default NA.
#' @return Barplot of top 5 most frequent adapter sequences.
#'
#' @examples
#' if(.Platform$OS.type != "windows") {
#' infile <- system.file("extdata", "test.fq.gz", package = "qckitfastq")
#' ac_sorted <- adapter_content(infile)
#' plot_adapter_content(ac_sorted)
#' }
#' @importFrom utils write.csv
#' @export
plot_adapter_content <- function(ac_sorted,output_file=NA){
    if(.Platform$OS.type == "windows") {
        stop("This function is not available on Windows due to the lack of C++14 support, sorry.")
    }
    ac <- ac_sorted[seq_len(5)]
    df<-data.frame(names(ac),as.numeric(ac))
    names(df) <- c("Adapters", "Counts")
    p <- ggplot2::ggplot(data=df,ggplot2::aes(x=.data$Adapters,y=.data$Counts)) +
      ggplot2::geom_bar(stat="identity") +
      ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1)) +
      ggplot2::ggtitle("Top 5 adapters and their counts in reads file") +
        ggplot2::xlab("Adapters") +
        ggplot2::ylab("Counts")
    if (!is.na(output_file)){ggplot2::ggsave(file=output_file,p)}
    return(p)
}