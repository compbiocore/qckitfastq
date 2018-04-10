testthat::test_that("Test Overrepresented Sequence",{

  #test whether the first row(largest counts) matches
  testthat::expect_equal(as.numeric(overrepresented_sequence(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckit"),"",25000)[1]),123)

})
