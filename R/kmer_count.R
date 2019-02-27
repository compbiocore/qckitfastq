#' Return kmer count per sequence for the length of kmer desired
#' @param infile the object that is the path to gzippped FASTQ file
#' @param k the length of kmer
#' @param output_file File to save plot to. Default NA.
#'
#' @return kmers counts per sequence
#' @importFrom utils write.csv
#' @importFrom tidyr gather
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
    df <- data.frame(fseq_count,check.names=FALSE)
    df$kmer <- rownames(df)
    tidy_fseq <- gather(df,head(colnames(df),-1),key="position",value="count")
    if(!is.na(output_file)){write.csv(file=output_file,tidy_fseq,row.names=FALSE)}
    return(fseq_count)
}
