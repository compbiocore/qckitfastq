testthat::test_that("GC",{
  #test the dimension of resulting dataset
  testthat::expect_equal(sum(GC_content(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))$count),25000)

  # first 3 lines of test.fq.gz are gc_content tests with allGC, 80/100GC, and 0GC  
  testfile<-system.file("extdata","test.fq.gz",package="qckitfastq")
  gc_content <- GC_content(testfile)
  testthat::expect_equal(gc_content[1,] %>% as.numeric, c(0,1))
  testthat::expect_equal(gc_content[10,] %>% as.numeric, c(80,1))
  testthat::expect_equal(gc_content[11,] %>% as.numeric, c(100,1))
})
