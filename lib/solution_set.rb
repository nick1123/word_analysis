class SolutionSet
  def initialize(solution_generator, max_population_size, solution_tester)
    @solution_generator = solution_generator
    @max_population_size = max_population_size
    @solution_tester = solution_tester
    @solutions = {}

    populate(true)
  end

  def iterate
    # kill off a member
    # add a new member
    # mutate a member
    #
    puts TournamentSelector.select_2_solutions_for_mating(@solutions.values).inspect
  end

  private

  def populate(create_random)
    while @solutions.keys.size < @max_population_size
      solution = @solution_generator.new_solution(create_random)
      solution.score = @solution_tester.solution_score(solution)
      @solutions[solution.finger_print] = solution
    end
  end

  def to_s
    @solutions.values.sort.join("\n")
  end
end
