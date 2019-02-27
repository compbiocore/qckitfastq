#' Creates a sorted from most frequent to least frequent abundance table
#' of adapters that are found to be present in the reads at greater than
#' 0.1\% of the reads. If output_file is selected then will save the
#' entire set of adapters and counts. Only available for macOS/Linux due to dependency
#' on C++14.
#' @param infile the path to a gzipped FASTQ file
#' @param adapter_file Path to adapters.txt file. Default from package.
#' @param output_file File to save data frame to. Default NA.
#' @return Sorted table of adapters and counts.
#'
#' @examples
#' if(.Platform$OS.type != "windows") {
#' infile <- system.file("extdata","test.fq.gz",
#'     package = "qckitfastq")
#' adapter_content(infile)[1:5]
#' }
#' @importFrom utils write.csv
#' @export
adapter_content <- function(infile,
                            adapter_file=system.file("extdata",
                                                    "adapters.txt",
                                                    package = "qckitfastq"),
                            output_file=NA){
    if(.Platform$OS.type == "windows") {
        stop("This function is not available on Windows due to the lack of C++14 support, sorry.")
    }
    ac <- calc_adapter_content(infile, adapter_file)
    nr <- as.numeric(ac["num_reads"]) # num_reads indicates nr in map
    ac <- ac[!names(ac)=="num_reads"] # remove num_reads from named vector
    if (!is.na(output_file)){
        ac_df <- data.frame(adapter=names(ac),count=ac)
        rownames(ac_df) <- seq(1, nrow(ac_df))
        write.csv(file=output_file,ac_df,row.names=FALSE)
        }
    ac_table <- ac[ac>0.001*nr]
    ac_sorted <- sort(ac_table,decreasing=TRUE)
    return(ac_sorted)
}