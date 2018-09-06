testthat::test_that("GC",{
  #test the dimension of resulting dataset
  testthat::expect_equal(nrow(GC_content(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))),25000)

  # first 3 lines of test.fq.gz are gc_content tests with allGC, 80/100GC, and 0GC  
  testfile<-system.file("extdata","test.fq.gz",package="qckitfastq")
  testthat::expect_equal(GC_content(testfile)[1:3,],c(100,80,0))
})
