#' Extract the dimensions for Fastq file
#'
#' \code{ncolumn}use seqTool to extract the dimensions of a Fastq G zipped file
#' @param fseq an object that is the read result of the seq.read function
#' @param selection "reads' for number of reads/rows, 'positions' for number of positions/columns
#' @return a numeric value of the number of reads or the number of positions
#' @examples
#'
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' fseq <- seqTools::fastqq(infile,k=6)
#' dimensions(fseq,"reads")
#'
#' @export


dimensions <- function(fseq,selection){
  ncolumn <- fseq@maxSeqLen
  nrow <- fseq@nReads
  if (selection == 'positions') return(ncolumn)

  if (selection  == 'reads') return(nrow)


}
