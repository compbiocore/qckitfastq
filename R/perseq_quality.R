#' Compute the mean quality score per sequence.
#' \code{perseq_quality}
#' @param infile Path to FASTQ file
#' @param output_file File to write plot to. Will not write to file if NA. Default NA.
#' @examples
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' perseq_quality <- perseq_quality(infile)
#' @return Data frame of mean quality score per read
#' @export
perseq_quality <- function(infile,output_file=NA){
    
    score_sequence_mean <- data.frame(qual_score_per_read(infile)$mu_per_read)
    colnames(score_sequence_mean) <- c("sequencemean")
    return(score_sequence_mean)
}