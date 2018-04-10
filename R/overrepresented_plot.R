#' Plot the top 5 seqeunces
#' @param overrep_order the table that sorts the sequence content and corresponding counts in descending order
#' @param prefix the prefix to the file saved
#' @param writefile boolean of whether to save file
#'
#' @return plot of the top 5 overrepresented sequences
#' @export


overrep_plot <- function(overrep_order,writefile=FALSE,prefix){

  if (writefile==TRUE){
  pdf(file = paste0(prefix,"OverrepresentedSequencePlot.pdf"))
  plot(density(overrep_order),main = "Overrepresented Sequence Histogram with top 5 rug",ylab="Density",xlab="Sequence Count")
  rug(overrep_order[1:5],col=2, lwd=3.5)
  dev.off()
  }else{
    plot(density(overrep_order),main = "Overrepresented Sequence Histogram with top 5 rug",ylab="Density",xlab="Sequence Count")
    rug(overrep_order[1:5],col=2, lwd=3.5)
  }
}
