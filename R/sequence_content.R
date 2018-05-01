#' Extract nucleoctide sequence content per position from fastq file
#' @param fseq an object that is the read result from seq.read function
#' @param content an object of string type that specifies the content in question, "A","T","G","C","N"(either capital or lower case)
#' @param writefile boolean true/false for whether to write file
#' @return the per position
#' @author Wenyue Xing, \email{wenyue_xing@@brown.edu}
#' @export

sequence_content <- function(fseq,content,writefile=FALSE){

  nucCount_seq <- seqTools::nucFreq(fseq,1)
  specific_content <- nucCount_seq[tolower(content),]
  #seq_content <- nucCount_seq[c(a,t,g,c,n)]
  if (writefile==TRUE){write.csv(file=paste0(prefix,"Sequence_Content.csv"),specific_content)}
  return(as.vector(specific_content))
}
