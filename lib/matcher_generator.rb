class MatcherGenerator
  def initialize(pre_sorted_substrings, quantity)
    @pre_sorted_substrings = pre_sorted_substrings
    @quantity = quantity
  end

  def new_set_of_matchers
    @pre_sorted_substrings[0..(@quantity - 1)]
    .map {|substring| Matchers::Substring.new(substring, random_value)}
  end

  private

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
