testthat::test_that("quality score",{

  testthat::expect_equal(as.numeric(per_base_quality(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))[1,]),c(2,32,32,32,32))
  testthat::expect_equal(as.numeric(per_base_quality(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))[2,]),c(12,32,32,32,32))

})
