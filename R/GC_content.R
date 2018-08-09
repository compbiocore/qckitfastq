#' Extract GC content separately and calculate GC content percentage for each sequence read
#' @param infile the object that is the path to the FASTQ file
#' @param writefile TRUE for writing the output to csv file
#' @param prefix the prefix of the output file if writefile is TRUE
#' @return plot of GC content
#' @examples
#'
#' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
#' GC_content(infile,FALSE)
#' @export
GC_content <- function(infile,writefile=FALSE,prefix){

  gc_result <- gc_per_read(infile)

  gc_df <- as.data.frame(gc_result*100)
  colnames(gc_df) = c("meanGC")
  if (writefile==TRUE) write.csv(file=paste0(prefix,"GCcontent.csv"),gc_df)
  return(gc_df)
}

