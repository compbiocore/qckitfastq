#' Extract nucleoctide sequence content per position from fastq file
#' @param fseq an object that is the read result from seq.read function
#' @param content an object of string type that specifies the content in question, "A","T","G","C","N"(either capital or lower case)
#' @param writefile boolean true/false for whether to write file
#' @param prefix to the output file if writefile=TRUE
#' @return the per position
#' @examples
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' fseq <- seqTools::fastqq(infile,k=6)
#' sequence_content(fseq,"A")
#' @author Wenyue Xing, \email{wenyue_xing@@brown.edu}
#' @export

sequence_content <- function(fseq,content,writefile=FALSE,prefix){

  nucCount_seq <- seqTools::nucFreq(fseq,1)
  specific_content <- nucCount_seq[tolower(content),]
  #seq_content <- nucCount_seq[c(a,t,g,c,n)]
  if (writefile==TRUE){write.csv(file=paste0(prefix,"Sequence_Content.csv"),specific_content)}
  return(as.vector(specific_content))
}
