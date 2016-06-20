require 'json'

class MatcherPreSort
  def initialize(positive_test_cases, negative_test_cases)
    @positive_test_cases = positive_test_cases
    @negative_test_cases = negative_test_cases
  end

  def sort_by_frequency
    array_of_single_char_substrings
    .concat(array_of_2_char_substrings)
    .map do |substring|
      positive_matches = consecutive_letters_match_count(substring, positive_test_cases)
      negative_matches = consecutive_letters_match_count(substring, negative_test_cases)
      total_matches    = positive_matches + negative_matches
      puts [substring, total_matches].inspect
      [substring, total_matches]
    end.sort {|a,b| b[1] <=> a[1]}.map {|arr| arr.join("\t")}
  end

  def build_matchers
    array_of_single_char_substrings
    .concat(array_of_2_char_substrings)
    .map do |substring|
      positive_matches = consecutive_letters_match_count(substring, positive_test_cases)
      negative_matches = consecutive_letters_match_count(substring, negative_test_cases)
      total_matches    = positive_matches + negative_matches
      hash = nil
      if total_matches > 0
        decimals = 4
        positive_percent = (100.0 * positive_matches / total_matches).round(decimals)
        negative_percent = (100.0 * negative_matches / total_matches).round(decimals)

        min_threshold = 51.0
        recommended_for = :none
        recommended_for = :positive_matches if positive_percent >= min_threshold
        recommended_for = :negative_matches if negative_percent >= min_threshold
        hash = {
          match: substring,
          positive_matches: positive_matches,
          negative_matches: negative_matches,
          total_matches:    total_matches,
          positive_percent: positive_percent,
          negative_percent: negative_percent,
          recommended_for:  recommended_for,
        }.to_json

        puts hash
      end

      hash
    end.compact
  end

  private

  # Lowercase English letters and the ' char
  # ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
  #  "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "'"]
  def array_of_single_char_substrings
    @array_of_single_char_substrings ||= (97..122).map {|int| int.chr } << "'"
  end

  def consecutive_letters_match_count(consecutive_letters, words)
    words.inject(0) { |sum, word| sum += (word.index(consecutive_letters) ? 1 : 0) }
  end

  # ["aa", "ab", ... "'z", "''"]
  def array_of_2_char_substrings
    @array_of_2_char_substrings ||= array_of_single_char_substrings.map do |a|
      array_of_single_char_substrings.map {|b| "#{a}#{b}" }
    end.flatten
  end

  # ["aaa", "aab", ... ]
  def array_of_3_char_substrings
    @array_of_3_char_substrings ||= array_of_2_char_substrings.map do |a|
      array_of_single_char_substrings.map {|b| "#{a}#{b}" }
    end#.flatten
  end
end
