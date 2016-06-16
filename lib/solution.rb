class Solution
  attr_accessor :score

  def initialize(matcher_generator, population_size)
    @matchers = (1..population_size).map {|i| matcher_generator.new_match}
    @score = 0
  end

  def is_word?(word)
    value = @matchers.inject(0) {|sum, matcher| sum + matcher.value_for_word(word) }
    return value > 0
  end

  def to_s
    ["score: #{@score}", @matchers.join("\t")].join("\t")
  end
end
