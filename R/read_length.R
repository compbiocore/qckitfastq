#' Creates a data frame of read lengths and the number of reads with
#' that read length.
#' 
#' @param fseq a seqTools object produced by seqTools::fastqq on the raw FASTQ file
#' @param output_file File to save data frame to. Default NA.
#' @return Data frame of read lengths and number of reads with that length.
#'
#' @examples
#' infile <- system.file("extdata","test.fq.gz",
#'     package = "qckitfastq")
#' fseq <- seqTools::fastqq(infile,k=6)
#' read_len <- read_length(fseq)
#' @importFrom utils write.csv
#' @export
read_length <- function(fseq, output_file=NA) {
    sl <- seqTools::seqLenCount(fseq)
    read_len <- data.frame(read_length = seq(1,length(sl)),
                           num_reads = as.vector(sl))
    if (!is.na(output_file)){write.csv(file=output_file,read_len,row.names=FALSE)}
    return(read_len)
}