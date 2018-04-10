#' Generate the data frame that includes percentiles of quality score per position
#' @param infile the object that is the dataframe of the mean, median and quantiles of the FASTQ file from basic statistics function
#' @param writefile the boolean of whether to write output as file
#' @param prefix the string of customized prefix of write-out file
#' @return table of quality score statistics
#' @export
#'
#' @author Wenyue Xing, \email{wenyue_xing@@brown.edu}

basic_stat <- function(infile,writefile=FALSE,prefix){

  qs <- qual_score_per_read(infile)
  bs <- data.frame(q01 = qs$q01_per_position,
                                 q25 = qs$q25_per_position,
                                 median = qs$q50_per_position,
                                 q75 = qs$q75_per_position,
                                 q99 = qs$q99_per_position)
  if (writefile==TRUE) write.csv(file=paste0(prefix,"basicstat.csv"),bs)
  return(bs)
}
