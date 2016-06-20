require 'digest'

class Solution
  attr_accessor :score
  attr_reader :matchers

  include Comparable

  def initialize(matchers, type)
    @matchers = matchers
    @type = type
    @score = 0
    @age = 1
  end

  def is_word?(word)
    value = @matchers.inject(0) {|sum, matcher| sum + matcher.value_for_word(word) }
    return value > 0
  end

  def increment_age
    @age += 1
  end

  def to_s
    [finger_print, "score #{@score}", "score density #{score_density.round(1)}", "age #{@age}", "type #{@type}", matchers_to_s].join("\t")
  end

  def <=>(other)
    score_density <=> other.score_density
  end

  def finger_print
    @finger_print ||= ("#{Digest::MD5.hexdigest(matchers_to_s)}")[0..5].to_sym
  end

  def score_density
    @score_density ||= compute_score_density
  end

  private

  def compute_score_density
    square = (score - 50) ** 2
    coefficient = (score >= 50 ? 1 : -1)
    # coefficient * (((score - 50) ** 2) / (@matchers.size.to_f ** 2)).round(2)
    # coefficient * (square / @matchers.size.to_f).round(3)
    # ((score - 50) / @matchers.size.to_f).round(3)
    # score
    # coefficient * ((score - 50) ** 2)
    coefficient * square

    score - 50
  end

  def matchers_to_s
    @matchers.join("\t")
  end
end
