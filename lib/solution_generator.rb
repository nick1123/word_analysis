class SolutionGenerator
  def initialize(matcher_generator, matchers_per_solution)
    @matcher_generator = matcher_generator
    @matchers_per_solution = matchers_per_solution
  end

  def new_solution(create_random)
    if create_random || rand >= 0.5
      random_solution
    end
  end

  def random_solution
    Solution.new(@matcher_generator, @matchers_per_solution)
  end

end
