#' Generate overrepresented kmers from all kmer counts results
#'
#' @param path the path to the gz file
#' @param k the length of the sequence looking for
#' @param nc number of positions
#' @param nr number of reads
#' @return the index of reads that has overrepresented kmers
#' @export

overrep_kmer <- function(path,k,nc,nr){
  fseq <- seqTools::fastqq(path)
  fseq_count <- seqTools::fastqKmerLocs(path,k)[[1]]

  # find marginal probabilities of ATGC

  probA <- sum(sequence_content(fseq,"A"))/nr/nc
  probG <- sum(sequence_content(fseq,"G"))/nr/nc
  probC <- sum(sequence_content(fseq,"C"))/nr/nc
  probT <- sum(sequence_content(fseq,"T"))/nr/nc

  #find the actual probabilities
  fseq_prob<-prop.table(fseq_count,2)

  #find the number of A, T, G, C in each kmer

  fseq_table = data.frame(matrix(ncol=4,nrow=nrow(fseq_count)))
  colnames(fseq_table) <- c("counta","countg","countt","countc")
  rownames(fseq_table) <- rownames(fseq_count)

  for (i in 1:nrow(fseq_count)){

    if (grepl("A",rownames(fseq_count)[i]) ==TRUE){
      fseq_table$counta[i] <- length(gregexpr("A",rownames(fseq_count)[i])[[1]])
    }else {
      fseq_table$counta[i] = 0
    }

    if (grepl("G",rownames(fseq_count)[i]) ==TRUE){
      fseq_table$countg[i] <- length(gregexpr("G",rownames(fseq_count)[i])[[1]])
    }else {
      fseq_table$countg[i] = 0
    }
    if (grepl("T",rownames(fseq_count)[i]) ==TRUE){
      fseq_table$countt[i] <- length(gregexpr("T",rownames(fseq_count)[i])[[1]])
    }else {
      fseq_table$countt[i] = 0
    }
    if (grepl("C",rownames(fseq_count)[i]) ==TRUE){
      fseq_table$countc[i] <- length(gregexpr("C",rownames(fseq_count)[i])[[1]])
    }else {
      fseq_table$countc[i] = 0
    }

  }

  #calculate expecte kmer per read

  fseq_table$expected <- ((probA^fseq_table$counta)*(probG^fseq_table$countg)*(probC^fseq_table$countc)*(probT^fseq_table$countt))

  # calculate an log2(obs/exp) as indicator for further analysis

   fseq_count_copy <- t(t(fseq_prob) / fseq_table$expected)
   fseq_count_log <- log2(fseq_count_copy)

  #find the index of large value and detect the kmer they belong to

  index_over <- which(fseq_count_log>=2,arr.ind = T)
  obsexp_ratio <- fseq_count_log[cbind(index_over[,1],index_over[,2])]
  index_over <- cbind(index_over,obsexp_ratio)



  index_overt <- data.table::data.table(index_over)
  index_split = split(index_overt,index_overt$row)
  index = do.call(rbind,sapply(index_split,simplify=FALSE, function(x)x[order(x$row,decreasing=TRUE),][1,]))
  indexes <- index_overt %>% dplyr::group_by(row) %>% dplyr::top_n(1,obsexp_ratio)

  #indexes <- data.table::data.table(index)[order(-obsexp_ratio,row)]
  indexes$kmer <- rownames(fseq_count_log)[indexes$row]
  write.csv(file="OverrepresentedKmers.csv",indexes)
  return(indexes)
}
