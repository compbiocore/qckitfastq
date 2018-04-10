#' Extract nucleoctide sequence content per position from fastq file
#' @param fseq an object that is the read result from seq.read function
#' @param content an object of string type that specifies the content in question, "A","T","G","C","N"(either capital or lower case)
#' @return the per position
#' @author Wenyue Xing, \email{wenyue_xing@@brown.edu}
#' @export

sequence_content <- function(fseq,content){

  nucCount_seq <- seqTools::nucFreq(fseq,1)
  specific_content <- nucCount_seq[tolower(content),]
  return(as.vector(specific_content))
}
