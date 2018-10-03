#include <Rcpp.h>
#include <iostream>
#include <map>
#include <fstream>
#include <iostream>
#include <string>
#include <algorithm>
#include <cstdint>
#include "gzstream.h"
#include "zlib.h"

using namespace Rcpp;

// [[Rcpp::plugins(cpp11)]]

//' Get Illumina format
//'
//' @param infile  A string giving the path for the fastqfile
//' @param buffer_size An int for the number of lines to keep in memory
//' @examples
//' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
//' find_format(infile,10000)
//' @return process fastq and evaluate the format of reads
//' @export
// [[Rcpp::export]]

std::string find_format(std::string infile, int buffer_size, int reads_used) {
    std::vector<int> qual_scores;
    std::vector<int>::iterator it;
    gz::igzstream in(infile.c_str());
    std::string line, score_format;
    int counter = 1;
    int line_count = 1;

    std::vector<double> gc_percent_all;
    while (std::getline(in, line)) {
        if (counter > reads_used) {
            break;
        } else {
            if (line_count == 4) {
                for (char &c : line) {
                    qual_scores.push_back(int(c));
                }

                /* alternative implementation basd on iterators
                 * for (std::string::iterator chit = line.begin(); chit != line.end(); ++chit)
                {
                    qual_scores.push_back(int(*chit));
                }*/

                line_count = 1;
                counter++;
            } else {
                line_count++;
            }
        }
    }
    int max_score = qual_scores.max();
    int min_score = qual_scores.min();

    if (min_score < 58 & max_score < 74) { score_format = "Sanger"; }
    else if (min_score > 58 & min_score < 64 & max_score > 74 & max_score < 105) { score_format = "Solexa"; }
    else if (min_score > 63 & min_score < 66 & max_score > 74 & max_score < 105) { score_format = "Illumina1.3"; }
    else if (min_score > 65 & max_score > 74) { score_format = "Solexa1.5"; }

    return score_format;
}

// [[Rcpp::plugins(cpp11)]]

//' Calculate score based on Illumina format
//'
//' @param score  An ascii quality score from the fastq
//' @param score_format The illumina format
//' @examples
//' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
//' find_format(infile,10000, 100000)
//' @return a string as with the best guess as to the illumina format
//' @export
// [[Rcpp::export]]

int calc_format_score(char score, std::string score_format)
{
    int calc_score = 0;
    switch (score_format)
    {
        case "Sanger":
            tmp_score = int(score) - 33;
            break;
        case "Solexa":
            tmp_score = int(score) - 64;
            break;
        case "Illumin1.3":
            tmp_score = int(score) - 64;
            break;
        case "Illumina1.5":
            tmp_score = int(score) - 64;
            break;
    }

    return calc_score;
}

// [[Rcpp::plugins(cpp11)]]

//' calculate Over Rep seqs
//'
//' @param infile  A string giving the path for the fastqfile
//' @param buffer_size An int for the number of lines to keep in memory
//' @examples
//' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
//' process_fastq(infile,10000)
//' @return process fastq and generate sequence and quality score tables
//' @export
// [[Rcpp::export]]


void process_fastq(std::string infile, int buffer_size, std::string format) {

    std::map<std::string, int> over_rep_map;
    std::map<std::string, int>::iterator it;
    std::map<int, std::vector<int> > qual_by_column;
    std::map < int, std::vector < int > > ::iterator
    qual_by_col_it;

    //std::string seq_out = out_prefix + ".seq.csv";
    //std::string qual_char_out = out_prefix + ".qual.char.csv";
    //std::string qual_num_out = out_prefix + ".qual.num.csv";
    //std::ofstream seq_file, qual_char_file, qual_num_file;

    // std::string over_rep_out = out_prefix + ".over_rep.csv";
    //std::ofstream over_rep_file;

    /*seq_file.open(seq_out.c_str());
    qual_char_file.open(qual_char_out.c_str());
    qual_num_file.open(qual_num_out.c_str());
    over_rep_file.open(over_rep_out.c_str());*/

    gz::igzstream in(infile.c_str());
    std::string line;
    int count = 1;

    //std::vector<int,std::vector<int> > base_counts;

    //Get the file format
    // Convert to if not given auto find
    std:: string score_format = find_format(infile,100000, 1000000);

    std::vector<double> gc_percent_all;

    while (std::getline(in, line)) {

        if (count == 2) {
            it = over_rep_map.find(line);
            if (it != over_rep_map.end()) {
                // if found increment by 1
                over_rep_map.at(line) += 1;
            } else {
                // if not found add new key and initialize to 1
                over_rep_map.insert(std::pair<std::string, int>(line, 1));
            }
            // iterating over each character in the string
            std::string base_cmp;
            //std::vector<int> counts_per_read;
            int count_A = 0, count_G = 0, count_T = 0, count_C = 0, count_N = 0;
            for (std::string::iterator it = line.begin(); it != line.end(); ++it) {
                base_cmp.clear();
                base_cmp.push_back(*it);
                if (base_cmp.compare("A") == 0) { count_A += 1; }
                else if (base_cmp.compare("T") == 0) { count_T += 1; }
                else if (base_cmp.compare("G") == 0) { count_G += 1; }
                else if (base_cmp.compare("C") == 0) { count_C += 1; }
                else if (base_cmp.compare("N") == 0) { count_N += 1; }
            }
            double gc_percent = static_cast<double>(count_C + count_G) /
                                static_cast<double>(count_A + count_T + count_G + count_C + count_N);
            gc_percent_all.push_back(gc_percent);
            /*counts_per_read.push_back(count_A);
            counts_per_read.push_back(count_T);
            counts_per_read.push_back(count_G);
            counts_per_read.push_back(count_C);
            counts_per_read.push_back(count_N);
            base_counts.insert(line_count,counts_per_read);*/

        }

        if (count == 4) {
            // iterate over each value for quality
            int pos_counter = 1;

            // calculated score by format
            int calc_score =0;

            for (std::string::iterator it = line.begin(); it != line.end(); ++it)
            {
                qual_by_col_it = qual_by_column.find(pos_counter);
                calc_score = calc_format_score(*it,score_format);

                if (qual_by_col_it != qual_by_column.end()) {
                    //qual_by_column.at(pos_counter).push_back(ascii_map.find(*it)->second);
                    qual_by_column.at(pos_counter).push_back(calc_score);
                } else {
                    std::vector<int> tmp;
                    //tmp.push_back(ascii_map.find(*it)->second);

                    tmp.push_back(calc_score);
                    qual_by_column.insert(std::pair < int, std::vector < int > > (pos_counter, tmp));
                }
            }
            count = 1;
        } else {
            count++;
        }
    }
    //Cleanup
    in.close();

    /*TODO
      write over_rep sequences to file
      return gc_percent vector
      return per column mean, median and quantile
     */
    //over_rep_file.close();

    return;
}


//' calculate summary of quality scores over position
//'
//' Description
//' @param inmat A matrix of score vectors per position

std::vector <std::vector<int>> qual_score_per_position(const std::map<int, std::vector<uint8_t> > &inmat) {
    std::vector <std::vector<int>> qual_score_mat_results;
    std::vector<int> q_10, q_25, q_50, q_75, q_90;

    std::map < int, std::vector < uint8_t > > ::const_iterator
    mat_it = inmat.begin();

    for (mat_it = inmat.begin(); mat_it != inmat.end(); mat_it++) {
        std::vector <uint8_t> quantile = mat_it->second;

        int Q10 = static_cast<int> (quantile.size() * 0.1);
        int Q25 = (quantile.size() + 1) / 4;
        int Q50 = (quantile.size() + 1) / 2;
        int Q75 = Q25 + Q50;
        int Q90 = static_cast<int> (quantile.size() * 0.9);

        std::nth_element(quantile.begin(), quantile.begin() + Q10, quantile.end());
        q_10.push_back(static_cast<int>(quantile[Q10]));
        quantile.clear();

        std::nth_element(quantile.begin(), quantile.begin() + Q25, quantile.end());
        q_25.push_back(static_cast<int>(quantile[Q25]));
        quantile.clear();

        quantile = mat_it->second;
        std::nth_element(quantile.begin(), quantile.begin() + Q50, quantile.end());
        q_50.push_back(static_cast<int>(quantile[Q50]));
        quantile.clear();

        quantile = mat_it->second;
        std::nth_element(quantile.begin(), quantile.begin() + Q75, quantile.end());
        q_75.push_back(static_cast<int>(quantile[Q75]));

        std::nth_element(quantile.begin(), quantile.begin() + Q90, quantile.end());
        q_90.push_back(static_cast<int>(quantile[Q90]));
        quantile.clear();
    }
    qual_score_mat_results.push_back(q_10);
    qual_score_mat_results.push_back(q_25);
    qual_score_mat_results.push_back(q_50);
    qual_score_mat_results.push_back(q_75);
    qual_score_mat_results.push_back(q_90);
    return qual_score_mat_results;
}

//' Calculate the mean quality score per read of the FASTQ gzipped file
//' 
//' @param infile A string giving the path for the fastqfile
//' @examples
//' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
//' qual_score_per_read(infile)$q50_per_position[1:10]
//' @return mean quality per read
//' @export
// [[Rcpp::export]]
Rcpp::List qual_score_per_read(std::string infile) {
/*    std::map<char, uint8_t> ascii_map;
    ascii_map['!'] = 0;
    ascii_map['"'] = 1;
    ascii_map['#'] = 2;
    ascii_map['$'] = 3;
    ascii_map['%'] = 4;
    ascii_map['&'] = 5;
    ascii_map['\''] = 6;
    ascii_map['('] = 7;
    ascii_map[')'] = 8;
    ascii_map['*'] = 9;
    ascii_map['+'] = 10;
    ascii_map[','] = 11;
    ascii_map['-'] = 12;
    ascii_map['.'] = 13;
    ascii_map['/'] = 14;
    ascii_map['0'] = 15;
    ascii_map['1'] = 16;
    ascii_map['2'] = 17;
    ascii_map['3'] = 18;
    ascii_map['4'] = 19;
    ascii_map['5'] = 20;
    ascii_map['6'] = 21;
    ascii_map['7'] = 22;
    ascii_map['8'] = 23;
    ascii_map['9'] = 24;
    ascii_map[':'] = 25;
    ascii_map[';'] = 26;
    ascii_map['<'] = 27;
    ascii_map['='] = 28;
    ascii_map['>'] = 29;
    ascii_map['?'] = 30;
    ascii_map['@'] = 31;
    ascii_map['A'] = 32;
    ascii_map['B'] = 33;
    ascii_map['C'] = 34;
    ascii_map['D'] = 35;
    ascii_map['E'] = 36;
    ascii_map['F'] = 37;
    ascii_map['G'] = 38;
    ascii_map['H'] = 39;
    ascii_map['I'] = 40;
    ascii_map['J'] = 41;
    ascii_map['K'] = 42;
    ascii_map['L'] = 43;
    ascii_map['M'] = 44;
    ascii_map['N'] = 45;
    ascii_map['O'] = 46;
    ascii_map['P'] = 47;
    ascii_map['Q'] = 48;
    ascii_map['R'] = 49;
    ascii_map['S'] = 50;
    ascii_map['T'] = 51;
    ascii_map['U'] = 52;
    ascii_map['V'] = 53;
    ascii_map['W'] = 54;
    ascii_map['X'] = 55;
    ascii_map['Y'] = 56;
    ascii_map['Z'] = 57;
    ascii_map['['] = 58;
    ascii_map['\\'] = 59;
    ascii_map[']'] = 60;
    ascii_map['^'] = 61;
    ascii_map['_'] = 62;
    ascii_map['`'] = 63;
    ascii_map['a'] = 64;
    ascii_map['b'] = 65;
    ascii_map['c'] = 66;
    ascii_map['d'] = 67;
    ascii_map['e'] = 68;
    ascii_map['f'] = 69;
    ascii_map['g'] = 70;
    ascii_map['h'] = 71;
    ascii_map['i'] = 72;
    ascii_map['j'] = 73;
    ascii_map['k'] = 74;
    ascii_map['l'] = 75;
    ascii_map['m'] = 76;
    ascii_map['n'] = 77;
    ascii_map['o'] = 78;
    ascii_map['p'] = 79;
    ascii_map['q'] = 80;
    ascii_map['r'] = 81;
    ascii_map['s'] = 82;
    ascii_map['t'] = 83;
    ascii_map['u'] = 84;
    ascii_map['v'] = 85;
    ascii_map['w'] = 86;
    ascii_map['x'] = 87;
    ascii_map['y'] = 88;
    ascii_map['z'] = 89;
    ascii_map['{'] = 90;
    ascii_map['|'] = 91;
    ascii_map['}'] = 92;
    ascii_map['~'] = 93;*/

    std::vector<double> quality_score_per_read;
    std::vector <uint8_t> qual_by_column;
    std::vector<uint8_t>::iterator qual_by_col_it;

    std::map<int, std::vector<uint8_t> > qual_score_matrix;

    gz::igzstream in(infile.c_str());
    std::string line;
    int count = 1;
    double quality_score_mean = 0;
    std::string score_format = find_format(infile, 100000, 1000000);
    while (std::getline(in, line))
    {

        if (count == 4)
        {
            // iterate over each value for quality
            qual_by_column.clear();
            int pos_counter = 1;
            int calc_score =0;
            for (std::string::iterator it = line.begin(); it != line.end(); ++it)
            {
                calc_score = calc_format_score(*it, score_format);

                qual_by_column.push_back(calc_score   );
                if (pos_counter <= qual_score_matrix.size()) {
                    qual_score_matrix[pos_counter].push_back(ascii_map.find(*it)->second);
                } else {
                    std::vector <uint8_t> tmp_qual;
                    tmp_qual.push_back(ascii_map.find(*it)->second);
                    std::pair < int, std::vector < uint8_t >> tmp = std::pair < int, std::vector <
                                                                                     uint8_t >> (pos_counter, tmp_qual);
                    qual_score_matrix.insert(tmp);
                }
                pos_counter++;
            }
            quality_score_mean = static_cast<double>(std::accumulate(qual_by_column.begin(), qual_by_column.end(),
                                                                     0.0)) / static_cast<double>(qual_by_column.size());
            quality_score_per_read.push_back(quality_score_mean);
            count = 1;
        } else {
            count++;
        }
    }
    std::vector <std::vector<int>> qual_score_summary_by_position;
    qual_score_summary_by_position = qual_score_per_position(qual_score_matrix);

    std::vector<double> mu_per_position;
    std::map < int, std::vector < uint8_t > > ::iterator
    mat_it = qual_score_matrix.begin();

    for (mat_it = qual_score_matrix.begin(); mat_it != qual_score_matrix.end(); mat_it++) {
        std::vector <uint8_t> quantile = mat_it->second;

        mu_per_position.push_back(static_cast<double>(std::accumulate(quantile.begin(),
                                                                      quantile.end(), 0.0)) /
                                  static_cast<double>(quantile.size()));
    }
    //Cleanup
    in.close();
    return Rcpp::List::create(Rcpp::Named("mu_per_read") = quality_score_per_read,
                              Rcpp::Named("mu_per_position") = mu_per_position,
                              Rcpp::Named("q10_per_position") = qual_score_summary_by_position[0],
                              Rcpp::Named("q25_per_position") = qual_score_summary_by_position[1],
                              Rcpp::Named("q50_per_position") = qual_score_summary_by_position[2],
                              Rcpp::Named("q75_per_position") = qual_score_summary_by_position[3],
                              Rcpp::Named("q90_per_position") = qual_score_summary_by_position[4]);
}


//' Calculate GC nucleotide sequence content per read of the FASTQ gzipped file
//' @param infile A string giving the path for the fastqfile
//' @examples
//' infile <- system.file("extdata", "10^5_reads_test.fq.gz", package = "qckitfastq")
//' gc_per_read(infile)[1:10]
//' @return GC content perncentage per read
//' @export
// [[Rcpp::export]]
Rcpp::NumericVector gc_per_read(std::string infile) {

    std::map<int, std::vector<int> > qual_by_column;
    std::map < int, std::vector < int > > ::iterator
    qual_by_col_it;


    gz::igzstream in(infile.c_str());
    std::string line;
    int count = 1;
    //std::vector<int,std::vector<int> > base_counts;
    std::vector<double> gc_percent_per_read;
    while (std::getline(in, line)) {

        if (count == 2) {
            // iterating over each character in the string
            std::string base_cmp;
            int count_A = 0, count_G = 0, count_T = 0, count_C = 0, count_N = 0;
            for (std::string::iterator it = line.begin(); it != line.end(); ++it) {
                base_cmp.clear();
                base_cmp.push_back(*it);
                if (base_cmp.compare("A") == 0) { count_A += 1; }
                else if (base_cmp.compare("T") == 0) { count_T += 1; }
                else if (base_cmp.compare("G") == 0) { count_G += 1; }
                else if (base_cmp.compare("C") == 0) { count_C += 1; }
                else if (base_cmp.compare("N") == 0) { count_N += 1; }
            }
            double gc_percent = static_cast<double>(count_C + count_G) /
                                static_cast<double>(count_A + count_T + count_G + count_C + count_N);
            gc_percent_per_read.push_back(gc_percent);
        }

        if (count == 4) {
            // Reset counter
            count = 1;
        } else {
            count++;
        }
    }
    //Cleanup
    in.close();

    return wrap(gc_percent_per_read);
}


//' Calculate sequece counts for each unique sequence and create a table with unique sequences
//' and corresponding counts
//' @param infile A string giving the path for the fastqfile
//' @param min_size An int for thhresholding over representation
//' @param buffer_size An int for the number of lines to keep in memory
//' @return calculate overrepresented sequence count
//' @export
// [[Rcpp::export]]
std::map<std::string, int> calc_over_rep_seq(std::string infile,
                                             int min_size = 5, int buffer_size = 1000000) {
    std::map<std::string, int> over_rep_map;
    std::map<std::string, int>::iterator it;
    std::map<int, std::vector<int> > qual_by_column;
    std::map < int, std::vector < int > > ::iterator
    qual_by_col_it;

    /*
     TODO: Check to see if this needs to be written to file instead

    std::string over_rep_out = out_prefix + ".over_rep.csv";
    std::ofstream over_rep_file;
    over_rep_file.open(over_rep_out.c_str());*/

    gz::igzstream in(infile.c_str());
    std::string line;
    int count = 1, line_count = 1;
    while (std::getline(in, line)) {

        if (count == 2) {
            it = over_rep_map.find(line);
            if (it != over_rep_map.end()) {
                // if found increment by 1
                over_rep_map.at(line) += 1;
            } else {
                // if not found add new key and initialize to 1
                over_rep_map.insert(std::pair<std::string, int>(line, 1));
            }
        }
        if (count == 4) {
            // reset count
            count = 1;
        } else {
            count++;
        }
        // Reduce map after 1^e6 reads
        if (line_count % buffer_size == 0) {
            it = over_rep_map.begin();
            while (it != over_rep_map.end()) {
                if (it->second <= min_size) {
                    std::map<std::string, int>::iterator erase_it = it;
                    it++;
                    over_rep_map.erase(erase_it);
                } else {
                    ++it;
                }

            }
        }
        line_count++;
    }
    //Cleanup
    in.close();


    /*TODO

    over_rep_file.close();
    */

    return over_rep_map;
}



