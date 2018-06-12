#' Search through your sequences and return the total proportion of your library which contains
#' adapter sequences, predefined in the file adapters.txt. It is also possible for the user to
#' give a different file as input; the function is relatively generic. Sequences however must
#' be in the same format as adapters.txt.
#' @param infile the path to the FASTQ file
#' @param writefile if TRUE, write output to csv file. FALSE by default.
#' @param prefix the prefix of the output file if writefile is TRUE
#' @param adapter_file filepath to the adapter sequences to search for. Default is extdata/adapters.txt.
#' @return proportion of adapter sequences
#' @export
adapter_content <- function(infile, writefile, prefix, adapter_file) {
  seqTools::kMerIndex()
  fastqKmerLocs
  fseq_count <- seqTools::fastqKmerLocs(infile,k)[[1]]
  if (writefile==TRUE){write.csv(file=paste0(prefix,"Kmercountts.csv"),fseq_count)}
  return(fseq_count)
}

#' Helper function to process adapter file.
#' @param adapter_file
#' @return data table
