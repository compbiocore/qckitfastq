#' Compute nucleotide content per position for a single base pair. Wrapper function around seqTools.
#' 
#' @param fseq a seqTools::fastqq object
#' @param content nucleotide. Options are "A","T","G","C","N"(either capital or lower case)
#' @return Nucleotide sequence content per position.
#' @examples
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' fseq <- seqTools::fastqq(infile,k=6)
#' read_base_content(fseq,"A")
#' @author Wenyue Xing, \email{wenyue_xing@@brown.edu}, August Guang \email{august_guang@@brown.edu}
#' @export
read_base_content <- function(fseq,content){
  nucCount_seq <- seqTools::nucFreq(fseq,1)
  specific_content <- nucCount_seq[tolower(content),]
  return(as.vector(specific_content))
}

#' Compute nucleotide content per position. Wrapper function around seqTools.
#' 
#' @param fseq a seqTools::fastqq object
#' @param output_file File to write results in CSV format to. Will not write to file if NA. Default NA.
#' @return Data frame of nucleotide sequence content per position
#' @examples
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' fseq <- seqTools::fastqq(infile,k=6)
#' read_content(fseq)
#' @importFrom utils write.csv
#' @export
read_content <- function(fseq, output_file=NA) {
    nucCount_seq <- seqTools::nucFreq(fseq,1)
    content <- nucCount_seq[c("a","c","t","g","n"),]
    df <- data.frame(position=seq(1,ncol(content)),as.data.frame(t(content)))
    if (!is.na(output_file)) write.csv(file=output_file,df,row.names=FALSE)
    return(df)
}