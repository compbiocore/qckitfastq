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
    gc_df <- data.frame(read = seq(1,length(gc_result)),
        mean_GC = gc_result*100)
    if (!is.na(output_file)) utils::write.csv(file=output_file,gc_df)
    return(gc_df)
}
