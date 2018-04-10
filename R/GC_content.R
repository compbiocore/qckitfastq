#' Extract GC content separately and calculate GC content percentage for each sequence read
#' @param infile the object that is the path to the FASTQ file
#' @return plot of GC content
#' @export


GC_content <- function(infile){

  gc_result <- gc_per_read(infile)

  gc_df <- as.data.frame(gc_result*100)
  colnames(gc_df) = c("meanGC")
  return(gc_df)
}
