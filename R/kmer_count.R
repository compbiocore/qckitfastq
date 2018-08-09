#' Return kmer count per sequence for the length of kmer desired
#' @param infile the object that is the path to gzippped FASTQ file
#' @param k the length of kmer
#' @param writefile TRUE for writing the output to csv file
#' @param prefix the prefix of the output file if writefile is TRUE
#'
#' @return  Kmers counts per sequence
#' @examples
#'
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' Kmer_count(infile,k=4)
#' @export
Kmer_count <- function(infile,k,writefile=FALSE,prefix){
  fseq_count <- seqTools::fastqKmerLocs(infile,k)[[1]]
  if (writefile==TRUE){write.csv(file=paste0(prefix,"Kmercountts.csv"),fseq_count)}
  return(fseq_count)
}
