#' One function to run them all
#'
#' @param infile  the path to the datafile, can be fastq file either g-zipped or not
#' @param foption TRUE for saving all output results to file, FALSE for explicitly outputting the output tables
#' @param poption TRUE for saving all plots to file, FALSE for displaying all plots
#' @param pref  if any above choice is TRUE, give the prefix to the customized output filename prefix
#' @importMethodsFrom seqTools fastqq
#'
#' @return  generate files from all functions
#' @export
run_all<- function(infile,foption,poption,pref){
  fseq <- seqTools::fastqq(infile)

  #extract dimension information
  nc <- dimensions(fseq,"positions")
  nr <- dimensions(fseq,"reads")
  dim_plot <- plot_sequence_length(fseq,writefile=poption,prefix = pref)

  #extract per base quality score statistics
  bs <- basic_stat(infile,writefile = foption,prefix = pref)
  qual_plot <- plot_quality_score(bs,writefile=poption,prefix=pref)

  #extract per base sequence content percentage
  scA <- sequence_content(fseq, content = "A")
  scT <- sequence_content(fseq, content = "T")
  scG <- sequence_content(fseq, content = "G")
  scC <- sequence_content(fseq, content = "C")
  scN <- sequence_content(fseq, content = "N")
  seq_count <- rbind(scA,scT,scG,scC,scN)
  colnames(seq_count) <- seq(1,100)
  if (foption==TRUE){write.csv(file=paste0(pref,"Seq_Content.csv"),seq_count)}

  plot_sequence_content(fseq,nr,nc,writefile = poption,prefix=pref)

  #extract GC content per read
  gc_df <- GC_content(infile,writefile = foption,prefix=pref)
  gc_plot<- plot_GC_content(nc,gc_df,writefile = poption,prefix=pref)

  #Per read sequence quality score
  plot_perseq_quality(infile,writefile=FALSE,prefix=pref)

  #Kmer & Overrepresented kmer
  km <- Kmer_count(infile,k=6,writefile = foption,prefix = pref)
  overkm <-overrep_kmer(infile,7,nc,nr,writefile = foption,prefix=pref)

  #overrep sequence
  overrep_seq <- overrep_sequence(infile,nr,prefix = pref)
  plot_overrep_seq(overrep_seq,writefile = poption,prefix=pref)
  }



