require 'digest'

class Solution
  attr_accessor :score

  include Comparable

  def initialize(matcher_generator, population_size)
    @matchers = (1..population_size).map {|i| matcher_generator.new_match}.sort
    @score = 0
  end

  def is_word?(word)
    value = @matchers.inject(0) {|sum, matcher| sum + matcher.value_for_word(word) }
    return value > 0
  end

  def to_s
    [finger_print, "score: #{@score}", matchers_to_s].join("\t")
  end

  def <=>(other)
    other.score <=> @score
  end

  def finger_print
    @finger_print ||= ("FP_#{Digest::MD5.hexdigest(matchers_to_s)}")[0..7].to_sym
  end

  private

  def matchers_to_s
    @matchers.join("\t")
  end
end
