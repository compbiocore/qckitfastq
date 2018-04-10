#' Return kmer count per sequence for the length of kmer desired
#' @param infile the object that is the path to gzippped FASTQ file
#' @param k the length of kmer
#'
#' @return  Kmers counts per sequence
#' @export



Kmer_count <- function(infile,k){
  fseq_count <- seqTools::fastqKmerLocs(infile,k)[[1]]
  return(fseq_count)
}
