#include <seqan/find.h>
#include <seqan/sequence.h>
#include <iostream>
#include <sstream>
#include <fstream>
#include "gzstream.h"
#include "zlib.h"

#define STRICT_R_HEADERS
#include <Rcpp.h>

// [[Rcpp::depends(RSeqAn)]]

using namespace Rcpp;
using namespace seqan;

// Read adapter file and turn into set of keys.
// @param adapter_file File with adapter names and sequences in tab-delimited pairs
// @return Vector of pairs where the 1st entry is the adapter name and the 2nd entry is the adapter sequence
// #TODO write wrap and import CharString wrap such that function can be exported
std::map<std::string, CharString> read_adapters(std::string adapter_file) {
  std::ifstream f;
  f.open(adapter_file);
  if (!f) {
    stop("Error: unable to open file");
  }

  // skip first 18 lines since they are text
  std::string line;
  for(int i=1; i < 18; i++) {
    std::getline(f,line);
  }

  std::string adapter;
  std::string sequence;
  std::map<std::string, CharString> adapters;
  while(std::getline(f,line)) {
    if(line.length()==0) {
      continue;
    }
    // from https://stackoverflow.com/questions/10617094/how-to-split-a-file-lines-with-space-and-tab-differentiation
    // and modified
    std::istringstream iss(line);
    std::getline(iss, adapter, '\t');
    std::getline(iss, sequence, '\t');

    adapters.insert(std::make_pair(adapter, sequence));
  }
  return(adapters);
}

//' Compute adapter content in reads. This function is only available for macOS/Linux.
//' 
//' @param infile filepath to fastq sequence
//' @param adapters filepath to adapters
//' @return map object with adapter names as the key and the number of times the adapters appears in the reads as the value
//' @examples
//' adapter_file <- system.file("extdata", "adapters.txt", package = "qckitfastq")
//' infile <- system.file("extdata", "test.fq.gz", package = "qckitfastq")
//' content <- calc_adapter_content(infile, adapter_file)
//' @export
// [[Rcpp::export]]
std::map<std::string, int> calc_adapter_content(std::string infile, std::string adapters) {
  // read adapter file and turn into set of Pattern objects to search for
  std::map<std::string, CharString> a = read_adapters(adapters);
  StringSet<CharString> needles;
  // needle_map is map of index corresponding to adapter sequence string for use with SeqAn finder algorithm
  std::map<int,std::string> needle_map;
  // adapter_map is map of adapter name and counts associated
  std::map<std::string, int> adapter_map;
  int i = 0;
  for (std::map<std::string, CharString>::iterator it=a.begin(); it!=a.end(); ++it) {
    appendValue(needles,it->second);
    needle_map.insert(std::pair<int,std::string>(i,it->first));
    adapter_map.insert(std::pair<std::string,int>(it->first,0));
    i++;
  }
  Pattern<StringSet<CharString>, WuManber> patterns(needles);
  
  // go thru file and count number of times adapters appear
  gz::igzstream in(infile.c_str());
  std::string line;
  int count = 1, line_count=1, buffer_size=1000000, min_size=5;
  while (std::getline(in, line)) {
    if(count==2) { // line 2 has seq
      CharString l(line.c_str());
      Finder<CharString> finder(l);
      while(find(finder,patterns)) {
        std::string adapter = needle_map.at(position(patterns));
        adapter_map.at(adapter) += 1;
      }
    }
    // line 4 has quality score, then on to next read of head/seq/+/quality so cycle thru
    if (count==4) {
      count = 1;
    } else {
      count++;
    }
  }
  adapter_map.insert(std::pair<std::string,int>("num_reads",line_count)); // get num reads for later
  return adapter_map;
}