testthat::test_that("Test read_content",{
  fseq <- seqTools::fastqq(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"),6)

  #test the dimensions of the dataset
  testthat::expect_equal( length(read_base_content(fseq,"g")),dimensions(fseq,"positions"))
  testthat::expect_equal( length(read_base_content(fseq,"t")),dimensions(fseq,"positions"))
  testthat::expect_equal( length(read_base_content(fseq,"a")),dimensions(fseq,"positions"))
  testthat::expect_equal( length(read_base_content(fseq,"c")),dimensions(fseq,"positions"))
  testthat::expect_equal( length(read_base_content(fseq,"n")),dimensions(fseq,"positions"))

  #test that the sum of read content for each position equals to total reads
  sum <- sum(read_content(fseq)[1,c("a","c","t","g","n")])
  testthat::expect_equal(sum,25000)
})
