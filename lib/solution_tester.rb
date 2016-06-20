class SolutionTester
  def initialize(positive_test_cases, negative_test_cases)
    @positive_test_cases = positive_test_cases
    @negative_test_cases = negative_test_cases
  end

  def solution_score(solution)
    correct_count = 0
    correct_count += @positive_test_cases.inject(0) do |sum, word|
      sum += (solution.is_word?(word) ? 1 : 0)
    end

    correct_count += @negative_test_cases.inject(0) do |sum, word|
      sum += (solution.is_word?(word) ? 0 : 1)
    end

    return (100.0 * correct_count / possible_correct).round(4)
  end

  private

  def possible_correct
    @possible_correct ||= @positive_test_cases.size + @negative_test_cases.size
  end
end
