class SolutionSet
  def initialize(matcher_generator, max_population_size, matchers_per_solution, solution_tester)
    @matcher_generator = matcher_generator
    @max_population_size = max_population_size
    @matchers_per_solution = matchers_per_solution
    @solution_tester = solution_tester
    @solutions = []

    populate_with_random_solutions
    score_solutions
  end

  def iterate

  end

  private

  def score_solutions
    @solutions.each do |solution|
      solution.score = @solution_tester.solution_score(solution)
    end
  end

  def populate_with_random_solutions
    while @solutions.size < @max_population_size
      @solutions << Solution.new(@matcher_generator, @matchers_per_solution)
    end
  end

  def to_s
    @solutions.join("\n")
  end
end
