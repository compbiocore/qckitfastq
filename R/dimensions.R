#' Extract the number of columns and rows for a FASTQ file using seqTools.
#'
#' @param fseq an object that is the read result of the seq.read function
#' @param sel 'reads' for #reads/rows, 'positions' for #positions/columns
#' @return a numeric value of the number of reads or the number of positions
#' @examples
#'
#' infile <- system.file("extdata","10^5_reads_test.fq.gz",
#'     package = "qckitfastq")
#' fseq <- seqTools::fastqq(infile,k=6)
#' dimensions(fseq,"reads")
#'
#' @export
dimensions <- function(fseq,sel){
    ncolumn <- fseq@maxSeqLen
    nrow <- fseq@nReads
    if (sel == 'positions') return(ncolumn)
    if (sel  == 'reads') return(nrow)
}
