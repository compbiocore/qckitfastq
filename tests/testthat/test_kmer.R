testthat::test_that("Test kmer",{

  kmer<-kmer_count(infile=system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"),k=6)
  #check the dimension of the kmer count
  testthat::expect_equal(ncol(kmer),3)
  #check the kmer sequence
  testthat::expect_equal(nrow(kmer),95*4^6) # 4^6 kmers, 95 positions if k=6

})
