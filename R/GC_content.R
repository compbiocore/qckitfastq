#' Calculates GC content percentage for each read in the dataset.
#' 
#' @param infile the object that is the path to the FASTQ file
#' @param output_file File to write results to. Default NA.
#' @return Data frame with read ID and GC content of each read.
#' @examples
#'
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz",
#'     package = "qckitfastq")
#' head(GC_content(infile))
#' 
#' @export
GC_content <- function(infile,output_file=NA){
    gc_result <- gc_per_read(infile)
    gc_df <- as.data.frame(table(gc_result*100))
    colnames(gc_df) <- c("GC_content", "count")
    gc_df$GC_content <- as.numeric(as.character(gc_df$GC_content))
    if (!is.na(output_file)) utils::write.csv(file=output_file,gc_df,row.names=FALSE)
    return(gc_df)
}
