// [[Rcpp::depends(RSeqAn)]]

#include <Rcpp.h>
#include <seqan/find.h>
#include <iostream>

using namespace seqan;
using namespace Rcpp;

//' Get adapter content
//' @export
// [[Rcpp::export]]
int main() {
  CharString haystack = "Simon, send more money!";
  CharString needle = "more";
  Finder<CharString> finder(haystack);
  Pattern<CharString, DPSearch<SimpleScore>> pattern(needle, SimpleScore(0,-2,-1));
  while(find(finder,pattern,-2)) {
    while(findBegin(finder,pattern,getScore(pattern))) {
      Rcpp::Rcout << '[' << beginPosition(finder) << '.' << endPosition(finder) << ")\t" << infix(finder) << std::endl;
    }
  }
  return 0;
}
//std::map<std::string adapter, std::vector<std::pair<int, int>>> adapter_content(std::string infile, std::string adapters) {
  // read adapter file and turn into set of keys
  // Turn adapter keys into Pattern objects to search for
  // For each line in infile:
    // Use DPSearch to find occurrences of adapters and their positions and output to return object
  // Return object
//  return x * 2;
//}


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically
// run after the compilation.
//

/*** R
main()
*/
