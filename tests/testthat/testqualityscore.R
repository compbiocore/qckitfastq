testthat::test_that("quality score",{

  testthat::expect_equal(as.numeric(basic_stat(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckit"))[1,]),c(2,32,32,32,32))
  testthat::expect_equal(as.numeric(basic_stat(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckit"))[2,]),c(12,32,32,32,32))

})
