testthat::test_that("Test Overrepresented Sequence",{

  #test whether the first row(largest counts) matches
  testthat::expect_equal(as.numeric(overrep_sequence(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckit"),25000,writefile =FALSE,prefix = "")[1]),123)

})
