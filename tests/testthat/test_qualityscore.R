testthat::test_that("Testing find_format adjusts accurately as num_reads changes",{
  infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
  testthat::expect_equal(find_format(infile, 100),"Sanger")
  
  test <- system.file("extdata", "test.fq.gz", package="qckitfastq")
  # first read has ASCII 67 as min, i.e. C so should be Illumina1.5
  testthat::expect_equal(find_format(test,1),"Illumina1.5")
  # second read has ASCII 64 as min, i.e. @ so should be Illumina1.3
  testthat::expect_equal(find_format(test,2),"Illumina1.3")
  # third read has ASCII 59 as min, i.e. ; so should be Solexa
  testthat::expect_equal(find_format(test,3),"Solexa")
  # fourth read has ASCII 45 as min, i.e. - so should be Sanger
  testthat::expect_equal(find_format(test,4),"Sanger")
  
  error <- system.file("extdata", "throw_error.fq.gz", package="qckitfastq")
  # read has ASCII outside of 33-126 (é) which should throw an exception since there's no encoding for it.
  testthat::expect_error(find_format(error,1))
})

testthat::test_that("Testing per_base_quality",{

  testthat::expect_equal(as.numeric(per_base_quality(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))[1,]),c(32,32,32,32,32))
  testthat::expect_equal(as.numeric(per_base_quality(system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq"))[2,]),c(32,32,32,32,32))

})
