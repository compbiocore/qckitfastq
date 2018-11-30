#' Return kmer count per sequence for the length of kmer desired
#' @param infile the object that is the path to gzippped FASTQ file
#' @param k the length of kmer
#' @param output_file File to save plot to. Default NA.
#'
#' @return kmers counts per sequence
#' @importFrom utils write.csv
#' @examples
#'
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz",
#'     package = "qckitfastq")
#' km<-kmer_count(infile,k=4)
#' km[1:20,1:10]
#' 
#' @export
kmer_count <- function(infile,k,output_file=NA){
    fseq_count <- seqTools::fastqKmerLocs(infile,k)[[1]]
    if(!is.na(output_file)){write.csv(file=output_file,fseq_count)}
    return(fseq_count)
}
