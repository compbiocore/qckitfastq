testthat::test_that("Test Overrepresented Reads",{

  #test whether the first row(largest counts) matches
  testthat::expect_equal(as.numeric(overrep_reads(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))[1,]$count),123)

})
