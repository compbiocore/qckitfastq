#' Creates a bar plot of the top 5 most present adapter sequences.
#' @param ac_sorted Sorted table of adapters and counts.
#' @param output_file File to save data frame to. Will not write to file if NA. Default NA.
#' @return Bar plot of top 5 most frequent adapter sequences, saved as a PDF file.
#'
#' @examples
#'
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' ac_sorted <- adapter_content(infile,nr=25000)
#' plot_adapter_content(ac_sorted)
#' 
#' @importFrom utils write.csv
#' @importFrom ggplot2 ggplot
#' @export
plot_adapter_content <- function(ac_sorted,output_file=NA){
    ac <- ac_sorted[1:5]
    df<-data.frame(names(ac),as.numeric(ac))
    names(df) <- c("Adapters", "Counts")
    p <- ggplot(df,aes(x=Adapters,y=Counts)) +
      geom_bar(stat="identity") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
      ggtitle("Top 5 adapters and their counts in reads file") 
    if (!is.na(output_file)){ggplot2::ggsave(file=output_file,p)}
}