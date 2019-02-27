testthat::test_that("Testing run_all",{
  infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
  testfolder <- tempdir()
  
  run_all(infile, testfolder)

  if(.Platform$OS.type != "windows") {
  # test that all expected files are in testfolder
  testthat::expect_equal(length(list.files(testfolder)),17)
  testthat::expect_equal(length(list.files(testfolder,pattern=".csv")),9)
  testthat::expect_equal(substr(list.files(testfolder)[1],1,10),"10^5_reads")
  }
  else {
      testthat::expect_equal(length(list.files(testfolder)),15)
      testthat::expect_equal(length(list.files(testfolder, pattern=".csv")),8)
  }
})
