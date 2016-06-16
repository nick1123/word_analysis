module Matchers
  class Substring
    def initialize(substring, value)
      @substring = substring
      @value     = value
    end

    def value_for_word(word)
      word.index(@substring) ? @value : 0
    end

    def to_s
      "#{@substring},#{@value}"
    end
  end
end
