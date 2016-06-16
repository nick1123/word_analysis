class MatcherGenerator
  def new_match
    Matchers::Substring.new(random_substring, random_value)
  end

  private

  def random_substring
    random_bool ? set_of_single_chars.shuffle[0] : build_2_letter_combos.shuffle[0]
  end

  def random_value
    random_bool ? 1 : -1
  end

  def random_bool
    rand >= 0.5
  end

  # ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
  #  "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "'"]
  def set_of_single_chars
    @set_of_single_chars ||= (97..122).map {|int| int.chr } << "'"
  end

  # ["aa", "ab", ... "'z", "''"]
  def build_2_letter_combos
    @build_2_letter_combos ||= set_of_single_chars.map {|a| set_of_single_chars.map {|b| "#{a}#{b}"}}.flatten
  end
end
