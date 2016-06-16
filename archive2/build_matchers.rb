# ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
#  "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "'"]
def build_alphabet
  (97..122).map {|int| int.chr } << "'"
end

def consecutive_letters_match_count(consecutive_letters, words)
  words.inject(0) { |sum, word| sum += (word.index(consecutive_letters) ? 1 : 0) }
end

# ["aa", "ab", ... "'z", "''"]
def build_2_letter_combos
  @build_2_letter_combos ||= build_alphabet.map {|a| build_alphabet.map {|b| "#{a}#{b}"}}.flatten[0..29]
end

def load_from_flat_file(file_name)
  IO.read(file_name).split(/\s+/)
end

def positive_test_cases
  @positive_test_cases ||= load_from_flat_file("positive_test_cases.txt")
end

def negative_test_cases
  @negative_test_cases ||= load_from_flat_file("negative_test_cases.txt")
end

def build_2_letter_matchers
  build_2_letter_combos.map do |letter_combo|
    {
      match: letter_combo,
      positive_matches: consecutive_letters_match_count(letter_combo, positive_test_cases),
      negative_matches: consecutive_letters_match_count(letter_combo, negative_test_cases),
    }
  end
end

File.open('matches_raw.txt', 'w') do |file_handle|
  file_handle.write(
    build_2_letter_matchers.map {|row| row.to_json}.join("\n")
  )
end

puts build_2_letter_matchers
