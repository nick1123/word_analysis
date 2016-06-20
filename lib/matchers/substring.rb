module Matchers
  class Substring
    attr_reader :substring
    include Comparable

    MUTATION_STRATEGIES = [
      :make_zero,
      :switch_sign,
      :make_non_zero,
      :add_10_percent,
      :add_10_percent,
      :add_10_percent,
      :add_10_percent,
      :add_10_percent,
      :subtract_10_percent,
      :subtract_10_percent,
      :subtract_10_percent,
      :subtract_10_percent,
      :subtract_10_percent,
    ]

    def initialize(substring, value)
      @substring = substring
      @value     = value
    end

    def value_for_word(word)
      word.index(@substring) ? @value : 0
    end

    def to_s
      "#{@substring},#{@value.round(1)}"
    end

    def <=>(other)
      @substring <=> other.substring
    end

    def copy
      Substring.new(@substring.clone, @value)
    end

    def mutate!
      strategy = MUTATION_STRATEGIES.shuffle[0]

      @value = 0            if strategy == :make_zero
      @value = random_value if strategy == :make_non_zero
      @value *= @value      if strategy == :switch_sign
      @value *= 1.1         if strategy == :add_10_percent
      @value *= 0.9         if strategy == :subtract_10_percent

      @value = 10  if @value > 10
      @value = -10 if @value < -10

      @value = @value.round(1)
    end

    def random_value
      random_sign * rand(10)
    end

    def random_sign
      random_bool ? 1 : -1
    end

    def random_bool
      rand >= 0.5
    end
  end
end
