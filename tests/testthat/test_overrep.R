testthat::test_that("Test Overrepresented Sequence",{

  #test whether the first row(largest counts) matches
  testthat::expect_equal(as.numeric(overrep_sequence(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"),25000,prefix = "")[1]),123)

})
