#' Will run all functions in the qckitfastq suite and save the data frames and plots to a user-provided directory.
#' Plot names are supplied by default.
#'
#' @param infile Path to gzipped FASTQ file
#' @param dir Directory to save results to
#'
#' @return  generate files from all functions
#' @importFrom utils head
#' @export
run_all<- function(infile,dir){
  fseq <- seqTools::fastqq(infile)

  #extract dimension information
  nc <- dimensions(fseq,"positions")
  nr <- dimensions(fseq,"reads")
  dim_plot <- plot_read_length(fseq,output_file=file.path(dir,"read_length.png"))

  #extract per base quality score statistics
  bs <- per_base_quality(infile,output_file=file.path(dir,"per_base_quality.csv"))
  knitr::kable(head(bs))
  plot_per_base_quality(bs,output_file=file.path(dir,"per_base_quality.png"))

  #extract per base sequence content percentage
  scA <- sequence_content(fseq, content = "A")
  scT <- sequence_content(fseq, content = "T")
  scG <- sequence_content(fseq, content = "G")
  scC <- sequence_content(fseq, content = "C")
  scN <- sequence_content(fseq, content = "N")
  seq_count <- rbind(scA,scT,scG,scC,scN)
  colnames(seq_count) <- seq(1,100)
  write.csv(file=file.path(dir,"sequence_content.csv"),seq_count)

  plot_sequence_content(fseq,nr,nc,output_file=file.path(dir,"sequence_content.png"))

  #extract GC content per read
  gc_df <- GC_content(infile,output_file=file.path(dir,"gc_content.csv"))
  gc_plot<- plot_GC_content(nc,gc_df,output_file=file.path(dir,"gc_content.png"))

  #Per read sequence quality score
  plot_perseq_quality(infile,output_file=file.path(dir,"perseq_quality.png"))

  #Kmer & Overrepresented kmer
  km <- kmer_count(infile,k=6,output_file=file.path(dir,"kmer_count.csv"))
  overkm <-overrep_kmer(infile,7,nc,nr,output_file=file.path(dir,"overrep_kmer.csv"))
  plot_overrep_kmer(overkm,output_file=file.path(dir,"overrep_kmer.png"))

  #overrep sequence
  overrep_seq <- overrep_sequence(infile,nr,output_file=file.path(dir,"overrep_seq.csv"))
  plot_overrep_seq(overrep_seq,output_file=file.path(dir,"overrep_seq.png"))
  }



