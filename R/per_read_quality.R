#' Compute the mean quality score per read.
#' \code{per_read_quality}
#' @param infile Path to FASTQ file
#' @param output_file File to write plot to. Will not write to file if NA. Default NA.
#' @examples
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' prq <- per_read_quality(infile)
#' 
#' @return Data frame of mean quality score per read
#' @export
per_read_quality <- function(infile,output_file=NA){
    qs <- qual_score_per_read(infile)$mu_per_read
    score_sequence_mean <- data.frame(read = seq(1,length(qs)),
                                      sequence_mean = qs)
    if (!is.na(output_file)) write.csv(file=output_file,score_sequence_mean,row.names=FALSE)
    return(score_sequence_mean)
}