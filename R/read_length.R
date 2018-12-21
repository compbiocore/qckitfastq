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
  read_len <- as.data.frame(seqTools::seqLenCount(fseq))
  read_len$read_length = as.numeric(rownames(read_len))
  colnames(read_len) = c("num_reads", "read_length") 
  if (!is.na(output_file)){write.csv(file=output_file,read_len)}
  return(read_len)
}