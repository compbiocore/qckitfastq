% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_all.R
\name{run_all}
\alias{run_all}
\title{Will run all functions in the qckitfastq suite and save the data frames
and plots to a user-provided directory. Plot names are supplied by default.}
\usage{
run_all(infile, dir)
}
\arguments{
\item{infile}{Path to gzipped FASTQ file}

\item{dir}{Directory to save results to}
}
\value{
Generate files from all functions
}
\description{
Will run all functions in the qckitfastq suite and save the data frames
and plots to a user-provided directory. Plot names are supplied by default.
}
\examples{
infile <- system.file("extdata", "test.fq.gz",
    package = "qckitfastq")
testfolder <- tempdir()
run_all(infile, testfolder)
}
