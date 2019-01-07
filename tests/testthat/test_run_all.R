testthat::test_that("Testing run_all",{
  infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
  testfolder <- tempdir()
  
  run_all(infile, testfolder)

  # test that all expected files are in testfolder
  testthat::expect_equal(length(list.files(testfolder)),17)
  testthat::expect_equal(length(list.files(testfolder,pattern=".csv")),9)
})
