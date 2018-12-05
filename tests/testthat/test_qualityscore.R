testthat::test_that("Testing per_base_quality",{

  testthat::expect_equal(as.numeric(per_base_quality(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))[1,]),c(32,32,32,32,32))
  testthat::expect_equal(as.numeric(per_base_quality(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))[2,]),c(32,32,32,32,32))

})
