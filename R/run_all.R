#' Will run all functions in the qckitfastq suite and save the data frames
#' and plots to a user-provided directory. Plot names are supplied by default.
#'
#' @param infile Path to gzipped FASTQ file
#' @param dir Directory to save results to
#' @return  Generate files from all functions
#' @examples
#' infile <- system.file("extdata", "test.fq.gz",
#'     package = "qckitfastq")
#' testfolder <- tempdir()
#' run_all(infile, testfolder)
#' @importFrom utils head
#' @export
run_all<- function(infile,dir){
  fseq <- seqTools::fastqq(infile)
  
  read_len <- read_length(fseq, output_file=file.path(dir,"read_length.csv"))
  plot_read_length(read_len,output_file=file.path(dir,"read_length.png"))

  #extract per base quality score statistics
  bs <- per_base_quality(infile,output_file=file.path(dir,"per_base_quality.csv"))
  plot_per_base_quality(bs,output_file=file.path(dir,"per_base_quality.png"))

  #extract per base sequence content percentage
  rc <- read_content(fseq,output_file=file.path(dir,"read_content.csv"))
  plot_read_content(rc,output_file=file.path(dir,"read_content.png"))

  #extract GC content per read
  gc_df <- GC_content(infile,output_file=file.path(dir,"gc_content.csv"))
  gc_plot<- plot_GC_content(gc_df,output_file=file.path(dir,"gc_content.png"))

  #Per read sequence quality score
  prq <- per_read_quality(infile,output_file=file.path(dir,"per_read_quality.csv"))
  plot_per_read_quality(prq,output_file=file.path(dir,"per_read_quality.png"))

  # kmer count (DOES NOT HAVE PLOT)
  km <- kmer_count(infile,k=6,output_file=file.path(dir,"kmer_count.csv"))
  
  # overrep kmers
  overkm <-overrep_kmer(infile,7,output_file=file.path(dir,"overrep_kmer.csv"))
  plot_overrep_kmer(overkm,output_file=file.path(dir,"overrep_kmer.png"))

  #overrep reads
  overrep_reads <- overrep_reads(infile,output_file=file.path(dir,"overrep_reads.csv"))
  plot_overrep_reads(overrep_reads,output_file=file.path(dir,"overrep_reads.png"))
  
  # adapter content
  if(.Platform$OS.type != "windows") {
  ac_sorted <- adapter_content(infile,output_file=file.path(dir,"adapter_content.csv"))
  plot_adapter_content(ac_sorted,output_file=file.path(dir,"adapter_content.png"))
  }
  else { print("adapter_content not available for Windows; skipping") }
  }



