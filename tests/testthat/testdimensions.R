testthat::test_that("dimensions",{
  #check row numbers and column numbers
  fseq <- seqTools::fastqq(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckit"))
  testthat::expect_equal(dimensions(fseq,"positions"),100)
  testthat::expect_equal(dimensions(fseq,"reads"),25000)

})
