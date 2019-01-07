#' Generate overrepresented kmers of length k based on their
#' observed to expected ratio at each position across all sequences
#' in the dataset. The expected proportion of a length k kmer assumes
#' site independence and is computed as the sum of the count of each
#' base pair in the kmer times the probability of observing that base
#' pair in the data set, i.e. P(A)count_in_kmer(A)+P(C)count_in_kmer(C)+...
#' The observed to expected ratio is computed as log2(obs/exp). Those with
#' obsexp_ratio > 2 are considered to be overrepresented and appear
#' in the returned data frame along with their position in the sequence.
#'
#' @param infile path to gzipped FASTQ file
#' @param k the kmer length
#' @param output_file File to save plot to. Default NA.
#'
#' @return Data frame with columns: Position (in read), Obsexp_ratio, & Kmer
#' @examples
#'
#' infile <-system.file("extdata", "10^5_reads_test.fq.gz",
#'     package = "qckitfastq")
#' overrep_kmer(infile,k=4)
#'
#' @importFrom dplyr %>%
#' @importFrom utils write.csv
#' @export
overrep_kmer <- function(infile,k,output_file=NA){
    fseq <- seqTools::fastqq(infile)
    fseq_count <- seqTools::fastqKmerLocs(infile,k)[[1]]

    # find marginal probabilities of ATGC
    read_content <- read_content(fseq)
    tot_bases <- sum(read_content[,2:6])
    probA <- sum(read_content['a'])/tot_bases
    probG <- sum(read_content['g'])/tot_bases
    probC <- sum(read_content['c'])/tot_bases
    probT <- sum(read_content['t'])/tot_bases

    #find the actual probabilities
    fseq_prob<-prop.table(fseq_count,2)

    #find the number of A, T, G, C in each kmer

    fseq_table = data.frame(matrix(ncol=4,nrow=nrow(fseq_count)))
    colnames(fseq_table) <- c("counta","countg","countt","countc")
    rownames(fseq_table) <- rownames(fseq_count)

    for (i in seq_len(nrow(fseq_count))){
        if (grepl("A",rownames(fseq_count)[i]) ==TRUE){
          fseq_table$counta[i] <- length(gregexpr("A",rownames(fseq_count)[i])[[1]])
    } else {
        fseq_table$counta[i] = 0
    }

    if (grepl("G",rownames(fseq_count)[i]) ==TRUE){
        fseq_table$countg[i] <- length(gregexpr("G",rownames(fseq_count)[i])[[1]])
    } else {
        fseq_table$countg[i] = 0
    }
    if (grepl("T",rownames(fseq_count)[i]) ==TRUE){
        fseq_table$countt[i] <- length(gregexpr("T",rownames(fseq_count)[i])[[1]])
    } else {
        fseq_table$countt[i] = 0
    }
    if (grepl("C",rownames(fseq_count)[i]) ==TRUE){
        fseq_table$countc[i] <- length(gregexpr("C",rownames(fseq_count)[i])[[1]])
    } else {
        fseq_table$countc[i] = 0
    }

    }

    #calculate expected kmer per read

    fseq_table$expected <- ((probA^fseq_table$counta)*
                            (probG^fseq_table$countg)*
                            (probC^fseq_table$countc)*
                            (probT^fseq_table$countt))

    # calculate an log2(obs/exp) as indicator for further analysis

     fseq_count_copy <- t(t(fseq_prob) / fseq_table$expected)
     fseq_count_log <- log2(fseq_count_copy)

    #find the index of large value and detect the kmer they belong to

    index_over <- which(fseq_count_log>=2,arr.ind = TRUE)
    obsexp_ratio <- fseq_count_log[cbind(index_over[,1],index_over[,2])]
    index_over <- cbind(index_over,obsexp_ratio)
    index_overt <- data.table::data.table(index_over)
    index_split = split(index_overt,index_overt$row)
    order_obx <- function(x) x[order(x$obsexp_ratio,decreasing=TRUE),][1,]
    index = do.call(rbind,lapply(index_split,
                                order_obx))
    indexes <- index_overt %>% dplyr::group_by(row) %>%
        dplyr::top_n(1,obsexp_ratio)
    indexes$kmer <- rownames(fseq_count_log)[indexes$row]
    #indexes <- dplyr::select(indexes, col, obsexp_ratio, kmer)
    colnames(indexes) <- c("row", "position", "obsexp_ratio", "kmer")
    reorder <- indexes[order(-indexes$obsexp_ratio),]
    if(!is.na(output_file)){write.csv(file=output_file,reorder)}
    return(reorder)
}
