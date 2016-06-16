class MatcherGenerator
  def new_match
    substring = build_2_letter_combos.shuffle[0]
    Matchers::Substring.new(substring, random_value)
  end

  private

  def random_value
    rand > 0.5 ? 1 : -1
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
