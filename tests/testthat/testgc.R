testthat::test_that("GC",{
  #test the dimension of resulting dataset
  testthat::expect_equal(nrow(GC_content(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckit"))),25000)
})
