#' Extract the dimensions for Fastq file
#'
#' \code{ncolumn}use seqTool to extract the dimensions of a Fastq G zipped file
#' @param fseq an object that is the read result of the seq.read function
#' @param selection "reads' for number of reads/rows, 'positions' for number of positions/columns
#' @return a numeric value of the number of reads or the number of positions
#' #' @export


dimensions <- function(fseq,selection){
  ncolumn <- fseq@maxSeqLen
  nrow <- fseq@nReads
  if (selection == 'positions') return(ncolumn)

  if (selection  == 'reads') return(nrow)


}
