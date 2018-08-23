#' Compute nucleoctide sequence content per position. Wrapper function around seqTools.
#' 
#' @param fseq a seqTools::fastqq object
#' @param content an object of string type that specifies the content in question, "A","T","G","C","N"(either capital or lower case)
#' @param output_file File to write results in CSV format to. Will not write to file if NA. Default NA.
#' @return Nucleotide sequence content per position.
#' @examples
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' fseq <- seqTools::fastqq(infile,k=6)
#' sequence_content(fseq,"A")
#' @author Wenyue Xing, \email{wenyue_xing@@brown.edu}, August Guang \email{august_guang@@brown.edu}
#' @export

sequence_content <- function(fseq,content,output_file=NA){
  nucCount_seq <- seqTools::nucFreq(fseq,1)
  specific_content <- nucCount_seq[tolower(content),]
  if (!is.na(output_file)){write.csv(file=output_file,specific_content)}
  return(as.vector(specific_content))
}