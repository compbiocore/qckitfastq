testthat::test_that("Test calc_adapter_content",{

  adapter_file <- system.file("extdata", "adapters.txt", package = "qckitfastq")
  infile <- system.file("extdata", "test.fq.gz", package="qckitfastq")
  content <- calc_adapter_content(infile, adapter_file)
  adapters <- names(content)

  count <- function(query) {
    as.numeric(content[adapters==query])
  }

  # Illumina single end adapter 1 with 2 mismatches is in 5 other adapter sequences:
  # Illumina_single_end_PCR_Primer_1 ; Illumina_single_end_sequencing_primer
  # Illumina_paired_end_adapter_1_long ; Illumina_paired_end_adapter_2_and_PCR_primer_1_copy1
  # Illumina_paired_end_adapter_2_and_PCR_primer_1_copy2
  testthat::expect_equal(count("Illumina Single End Adapter 1"), 5)
  # Illumina paired end adapter 2 and PCR primer 1 are in same 2 reads
  testthat::expect_true("Illumina Paired End Adapter 2" %in% adapters)
  testthat::expect_equal(count("Illumina Paired End Adapter 2"),count("Illumina Paired End PCR Primer 1"))
  # Illumina paired end PCR primer 2 has 2 mismatches
  testthat::expect_equal(count("Illumina Paired End PCR Primer 2"),1)
  # Illumina paired end sequencing primer has 1 mismatch but appears to be in 6 reads (test wasn't accounted for)
  #testthat::expect_equal(count("Illumina Paired End Sequencing Primer 1"),6)
  # Illumina paired end sequencing primer 2 has 3 mismatches so should not be present (hm)
  #testthat::expect_false("Illumina Paired End Sequencing Primer 2" %in% adapters)
})

testthat::test_that("Test adapter_content",{
  
  infile <- system.file("extdata", "test.fq.gz", package="qckitfastq")
  adapters <- adapter_content(infile, 14)
  
  # Max should be 6 from Illumina Paired End Adapter 1 and others with the same adapter sequence
  testthat::expect_equal(as.numeric(adapters[1]), 6)
  # All entries in table should be greater than 0.001*14 (i.e. 0 in this case)
  testthat::expect_gt(min(adapters), 0)
  
  infile2 <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
  adapters2 <- adapter_content(infile, 25000)
  # All entries in table should be greater than 0.001*25000=25
  testthat::expect_gt(min(adapters2),25)
})