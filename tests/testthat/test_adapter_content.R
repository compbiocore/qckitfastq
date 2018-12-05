testthat::test_that("Test calc_adapter_content",{

  adapter_file <- system.file("extdata", "adapters.txt", package = "qckitfastq")
  infile <- system.file("extdata", "test.fq.gz", package="qckitfastq")
  content <- calc_adapter_content(infile, adapter_file)
  adapters <- names(content)

  count <- function(query) {
    as.numeric(content[adapters==query])
  }
  
  testthat::expect_error(calc_adapter_content(infile,''))

  # Illumina single end adapter 1 is not in file
  testthat::expect_false("Illumina Single End Adapter 1" %in% adapters)
  # Illumina paired end adapter 2 and PCR primer 1 are in same 2 reads but PCR primer is also in read above
  testthat::expect_equal(count("Illumina Paired End Adapter 2"),2)
  testthat::expect_equal(count("Illumina Paired End PCR Primer 1"),3)
  # Illumina single end adapter 2 and PCR primer 2 are the same sequence
  testthat::expect_equal(count("Illumina Single End Adapter 2"),count("Illumina Single End PCR Primer 2"))
  # Illumina paired end PCR primer 2 has 2 mismatches
  testthat::expect_false("Illumina Paired End PCR Primer 2" %in% adapters)
  # Illumina paired end sequencing primer has 1 mismatch but is in 5 other sequences
  testthat::expect_equal(count("Illumina Paired End Sequencing Primer 1"),5)
  # Illumina paired end sequencing primer 2 has 3 mismatches
  testthat::expect_false("Illumina Paired End Sequencing Primer 2" %in% adapters)
})

testthat::test_that("Test adapter_content",{
  
  infile <- system.file("extdata", "test.fq.gz", package="qckitfastq")
  adapters <- adapter_content(infile, 14)
  
  # Max should be 5 from Illumina Paired End Adapter 1 and others with the same adapter sequence
  testthat::expect_equal(as.numeric(adapters[1]), 5)
  # All entries in table should be greater than 0.001*14 (i.e. 0 in this case)
  testthat::expect_gt(min(adapters), 0)
  
  infile2 <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
  adapters2 <- adapter_content(infile, 25000)
  # All entries in table should be greater than 0.001*25000=25
  testthat::expect_gt(min(adapters2),25)
})
