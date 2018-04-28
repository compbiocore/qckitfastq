testthat::test_that("Test sequence content",{
  fseq <- seqTools::fastqq(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckit"),6)

  #test the dimensions of the dataset
  testthat::expect_equal( length(sequence_content(fseq,"g")),dimensions(fseq,"positions"))
  testthat::expect_equal( length(sequence_content(fseq,"t")),dimensions(fseq,"positions"))
  testthat::expect_equal( length(sequence_content(fseq,"a")),dimensions(fseq,"positions"))
  testthat::expect_equal( length(sequence_content(fseq,"c")),dimensions(fseq,"positions"))
  testthat::expect_equal( length(sequence_content(fseq,"n")),dimensions(fseq,"positions"))

  #test that the sum of seqence content for each positions equals to total reads
  sum <- sequence_content(fseq,"g")[1]+sequence_content(fseq,"t")[1]+sequence_content(fseq,"a")[1]+sequence_content(fseq,"c")[1]+sequence_content(fseq,"n")[1]
  testthat::expect_equal(sum,dimensions(fseq,"reads"))
})
