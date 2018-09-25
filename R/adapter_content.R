#' Search through sequences and return the total proportion of the library which contains
#' adapter sequences, predefined in the file adapters.txt. It is also possible for the user to
#' give a different file as input; the function is relatively generic. Sequences however must
#' be in the same format as adapters.txt, that is name tab sequence.
#'
#' @param infile the path to the FASTQ file
#' @param adapter_file filepath to the adapter sequences to search for. Default is extdata/adapters.txt.
#' @return proportion of adapter sequences
#' @export
adapter_content <- function(infile, adapter_file) {
  # TODO
  seqTools::kMerIndex()
  #fseq_count <- seqTools::fastqKmerLocs(infile)[[1]]
  #if (writefile==TRUE){write.csv(file=paste0(prefix,"Kmercountts.csv"),fseq_count)}
  #return(fseq_count)
  return(0)
}

#' Helper function to process adapter file.
#' @param adapter_file Text file storing adapters names and sequences.
#' @return data table
process_adapter_file <- function(adapter_file) {
  file<-read.csv(file=adapter_file, comment.char="#",sep="\t",col.names=c("name","sequence")) %>%
    dplyr::mutate(nchar(as.character(sequence))) %>%
    group_by(nc)
  return(file)
}
